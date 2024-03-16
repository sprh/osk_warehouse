import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../data/product_list_repository.dart';
import '../../models/product.dart';

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
        if (event.products.isEmpty) {
          await _navigationManager.showSomethingWentWrontDialog(
            'Не найдено ни одного товара на выбранном складе',
          );
          _navigationManager.pop();
        } else {
          final selectedProducts = event.products
              .where((e) => _selectedProducts.contains(e.id))
              .map((e) => e.id)
              .toSet();
          emit(
            SelectProductsStateData(event.products, selectedProducts),
          );
        }
      case SelectProductsEventOnSelect():
        final state = this.state as SelectProductsStateData;

        if (state.selectedProductIds.contains(event.id)) {
          emit(
            SelectProductsStateData(
              state.products,
              state.selectedProductIds.where((id) => id != event.id).toSet(),
            ),
          );
        } else {
          emit(
            SelectProductsStateData(
              state.products,
              {...state.selectedProductIds, event.id},
            ),
          );
        }
    }
  }

  @override
  Future<void> close() {
    super.stop();
    _repository.stop();
    return super.close();
  }
}
