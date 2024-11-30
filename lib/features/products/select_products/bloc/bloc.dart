import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../data/product_list_repository.dart';
import '../../models/product.dart';
import '../../product_list/bloc/state.dart';
import '../../product_list/presentation/product_list_search_page.dart';

part 'event.dart';
part 'state.dart';

typedef OnSelectProducts = void Function(List<Product>);

abstract class SelectProductsBloc
    extends Bloc<SelectProductsEvent, SelectProductsState> {
  static SelectProductsBloc of(BuildContext context) =>
      BlocProvider.of<SelectProductsBloc>(context);

  factory SelectProductsBloc(
    ProductListRepository repository,
    OnSelectProducts onSelect,
    String? warehouseId,
    AccountScopeNavigationManager navigationManager,
    Set<String> selectedProductsIds,
  ) =>
      _SelectProductsBloc(
        repository,
        onSelect,
        warehouseId,
        navigationManager,
        selectedProductsIds,
      );
}

class _SelectProductsBloc extends Bloc<SelectProductsEvent, SelectProductsState>
    with RepositorySubscriber<List<Product>>
    implements SelectProductsBloc {
  final ProductListRepository _repository;
  final void Function(List<Product>) _onSelect;
  final String? _warehouseId;
  final AccountScopeNavigationManager _navigationManager;
  final Set<String> _selectedProducts;

  _SelectProductsBloc(
    this._repository,
    this._onSelect,
    this._warehouseId,
    this._navigationManager,
    this._selectedProducts,
  ) : super(SelectProductsStateIdle()) {
    on<SelectProductsEvent>(_onEvent);
  }

  @override
  Repository<List<Product>> get repository => _repository;

  @override
  void onData(List<Product> value) => add(_SelectProductsEventOnData(value));

  @override
  void onLoading(bool loading) {}

  @override
  void onRepositoryError(RepositoryLocalizedError error) =>
      _navigationManager.showSomethingWentWrontDialog(
        error.message,
      );

  Future<void> _onEvent(
    SelectProductsEvent event,
    Emitter<SelectProductsState> emit,
  ) async {
    switch (event) {
      case SelectProductsEventInitialize():
        _repository.start();
        start();
        await _repository.refreshProductList(warehouseId: _warehouseId);
      case SelectProductsEventDoneButtonTap():
        final state = this.state as SelectProductsStateData;
        _onSelect(
          state.products
              .where((e) => state.selectedProductIds.contains(e.id))
              .toList(),
        );
        _navigationManager.pop();
      case _SelectProductsEventOnData():
        final state = this.state;
        late final hasActiveSearch = switch (state) {
          SelectProductsStateIdle() => false,
          SelectProductsStateData() => state.searchData.hasActiveSearch,
        };

        if (event.products.isEmpty && !hasActiveSearch) {
          await _navigationManager.showSomethingWentWrontDialog(
            'Не найдено ни одного товара на выбранном складе',
          );
          _navigationManager.pop();
        } else if (state is SelectProductsStateIdle) {
          final selectedProducts = event.products
              .where((e) => _selectedProducts.contains(e.id))
              .map((e) => e.id)
              .toSet();
          emit(
            SelectProductsStateData(
              event.products,
              selectedProducts,
              const ProductListSearchDataAvailable(),
            ),
          );
        } else if (state is SelectProductsStateData) {
          emit(
            state.copyWith(
              products: event.products,
            ),
          );
        }
      case SelectProductsEventOnSelect():
        final state = this.state as SelectProductsStateData;

        if (state.selectedProductIds.contains(event.id)) {
          emit(
            state.copyWith(
              selectedProductIds: state.selectedProductIds
                  .where((id) => id != event.id)
                  .toSet(),
            ),
          );
        } else {
          emit(
            state.copyWith(
              selectedProductIds: {...state.selectedProductIds, event.id},
            ),
          );
        }
      case SelectProductsEventOpenSearch():
        final state = this.state as SelectProductsStateData;

        await _openSearchList(
          state.searchData,
        );
      case SelectProductsEventOnSearchUpdated():
        await _onSearchUpdated(
          event.textToSearch,
          event.selectedCategory,
          emit,
        );
    }
  }

  Future<void> _openSearchList(ProductListSearchDataAvailable data) async {
    await _navigationManager.showModal(
      (context) => ProductListSearchBottomPane(
        data: data,
        onSearchUpdated: (textToSearch, selectedCategory) => add(
          SelectProductsEventOnSearchUpdated(
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
    Emitter<SelectProductsState> emit,
  ) async {
    final state = this.state;

    if (state is SelectProductsStateData) {
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
        warehouseId: _warehouseId,
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
