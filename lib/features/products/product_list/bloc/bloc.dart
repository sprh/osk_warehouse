import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/actions/actions_flex.dart';
import '../../../../common/components/button/osk_button.dart';
import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../../user/current_user_holder/current_user_holder.dart';
import '../../data/product_list_repository.dart';
import '../../models/product.dart';
import '../presentation/product_list_search_page.dart';
import 'state.dart';

part 'event.dart';

abstract class ProductListBloc
    extends Bloc<ProductListEvent, ProductListState> {
  static ProductListBloc of(BuildContext context) => BlocProvider.of(context);

  factory ProductListBloc(
    AccountScopeNavigationManager navigationManager,
    ProductListRepository repository,
    String? warehouseId,
    CurrentUserHolder currentUserHolder,
  ) = _ProductListBloc;
}

class _ProductListBloc extends Bloc<ProductListEvent, ProductListState>
    with RepositorySubscriber<List<Product>>
    implements ProductListBloc {
  final AccountScopeNavigationManager _navigationManager;
  final ProductListRepository _repository;
  final String? warehouseId;
  final CurrentUserHolder _currentUserHolder;

  _ProductListBloc(
    this._navigationManager,
    this._repository,
    this.warehouseId,
    this._currentUserHolder,
  ) : super(ProductListInitialState()) {
    on<ProductListEvent>(_onEvent);
  }

  @override
  Repository<List<Product>> get repository => _repository;

  Future<void> _onEvent(
    ProductListEvent event,
    Emitter<ProductListState> emit,
  ) async {
    switch (event) {
      case ProductListEventInitialize():
        _repository.start();
        start();
        await _repository.refreshProductList(warehouseId: warehouseId);
      case ProductListEventAddNewProduct():
        _navigationManager.openProductData();
      case ProductListEventDeleteProduct():
        await _navigationManager.showModalDialog(
          title: 'Вы уверены, что хотите удалить товар?',
          actions: OskActionsFlex(
            direction: Axis.vertical,
            widgets: [
              OskButton.main(
                title: 'Удалить',
                onTap: () {
                  _navigationManager.popDialog();
                  _repository.deleteProduct(event.id, warehouseId: warehouseId);
                },
              ),
              OskButton.minor(
                title: 'Отмена',
                onTap: _navigationManager.popDialog,
              ),
            ],
          ),
        );
      case _ProductListUpdateStateEvent():
        await _onProductListUpdate(event.products, event.loading, emit);
      case ProductListProductTapEvent():
        _navigationManager.openProductData(productId: event.id);
      case ProductListEventOpenSearch():
        await _openSearchList(event.data);
      case ProductListEventOnSearchUpdated():
        await _onSearchUpdated(
          event.textToSearch,
          event.selectedCategory,
          emit,
        );
    }
  }

  @override
  void onData(List<Product> value) =>
      add(_ProductListUpdateStateEvent(products: value));

  @override
  void onLoading(bool loading) => add(
        _ProductListUpdateStateEvent(loading: loading),
      );

  @override
  void onRepositoryError(RepositoryLocalizedError error) =>
      _navigationManager.showSomethingWentWrontDialog(error.message);

  Future<void> _onProductListUpdate(
    List<Product>? products,
    bool? loading,
    Emitter<ProductListState> emit,
  ) async {
    final state = this.state;

    final currentUser = await _currentUserHolder.currentUser;
    if (state is ProductListDataState) {
      emit(
        state.copyWith(
          loading: state.loading,
          products: products,
          showCreateProductButton:
              currentUser.canManagerProducts && warehouseId == null,
        ),
      );
    } else if (products != null) {
      final searchData = warehouseId == null
          ? const ProductListSearchDataNotAvailable()
          : const ProductListSearchDataAvailable();
      emit(
        ProductListDataState(
          products,
          loading: loading ?? false,
          showCreateProductButton:
              currentUser.canManagerProducts && warehouseId == null,
          // Поиск по товарам доступен только на экране склада
          searchData: searchData,
        ),
      );
    }
  }

  Future<void> _openSearchList(ProductListSearchDataAvailable data) async {
    await _navigationManager.showModal(
      (context) => ProductListSearchBottomPane(
        data: data,
        onSearchUpdated: (textToSearch, selectedCategory) => add(
          ProductListEventOnSearchUpdated(
            textToSearch,
            selectedCategory,
          ),
        ),
      ),
    );
  }

  Future<void> _onSearchUpdated(
    String? textToSearch,
    String? selectedCategory,
    Emitter<ProductListState> emit,
  ) async {
    final state = this.state;

    if (state is ProductListDataState) {
      emit(
        state.copyWith(
          searchData: ProductListSearchDataAvailable(
            productName: textToSearch,
            selectedCategory: selectedCategory,
          ),
        ),
      );
      _navigationManager.popDialog();
      await _repository.refreshProductList(
        warehouseId: warehouseId,
        searchText: textToSearch,
        searchCategory: selectedCategory,
      );
    }
  }

  @override
  Future<void> close() {
    super.stop();
    return super.close();
  }
}
