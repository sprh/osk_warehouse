import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/navigation_manager.dart';
import '../../../warehouse/models/warehouse.dart';
import '../../data/product_repository.dart';
import '../../models/product.dart';
import 'state.dart';

part 'events.dart';

abstract class ProductDataBloc
    extends Bloc<ProductDataPageEvent, ProductDataState> {
  static ProductDataBloc of(BuildContext context) => BlocProvider.of(context);

  factory ProductDataBloc(
    AccountScopeNavigationManager navigationManager,
    ProductRepository repository,
    String? productId,
  ) =>
      _ProductDataBloc(
        navigationManager,
        repository,
        productId: productId,
      );
}

class _ProductDataBloc extends Bloc<ProductDataPageEvent, ProductDataState>
    with RepositorySubscriber<(Product?, List<Warehouse>)>
    implements ProductDataBloc {
  final AccountScopeNavigationManager _navigationManager;
  final ProductRepository _repository;
  final String? productId;

  _ProductDataBloc(
    this._navigationManager,
    this._repository, {
    required this.productId,
  }) : super(ProductDataStateInitial()) {
    on<ProductDataPageEvent>(_onEvent);
  }

  @override
  Repository<(Product?, List<Warehouse>)> get repository => _repository;

  Future<void> _onEvent(
    ProductDataPageEvent event,
    Emitter<ProductDataState> emit,
  ) async {
    switch (event) {
      case ProductDataPageEventInitialize():
        _repository.start();
        start();
        await _repository.refreshData(productId);
      case _ProductDataPageEventSetLoading():
        _maybeSetLoading(event.loading, emit);
      case _ProductDataPageEventSetData():
        _setData(event.product, emit);
      case ProductDataPageEventAddOrUpdateProduct():
        _addOrUpdateProduct(event);
    }
  }

  @override
  void onData((Product?, List<Warehouse>) value) => add(
        _ProductDataPageEventSetData(
          product: value.$1,
        ),
      );

  @override
  void onLoading(bool loading) => add(_ProductDataPageEventSetLoading(loading));

  @override
  void onRepositoryError(RepositoryLocalizedError error) =>
      _navigationManager.showSomethingWentWrontDialog(error.message);

  void _maybeSetLoading(bool loading, Emitter<ProductDataState> emit) {
    final state = this.state;
    switch (state) {
      case ProductDataStateInitial():
        break;
      case ProductDataStateUpdate():
        emit(
          ProductDataStateUpdate(
            product: state.product,
            loading: loading,
          ),
        );
      case ProductDataStateCreate():
        emit(
          ProductDataStateCreate(
            loading: loading,
          ),
        );
    }
  }

  void _setData(
    Product? product,
    // List<Warehouse> warehouses,
    Emitter<ProductDataState> emit,
  ) {
    if (product != null) {
      emit(
        ProductDataStateUpdate(product: product),
      );
    } else {
      emit(const ProductDataStateCreate());
    }
  }

  void _addOrUpdateProduct(
    ProductDataPageEventAddOrUpdateProduct event,
  ) {
    final productId = this.productId;
    try {
      if (productId != null) {
        _repository.updateProduct(
          id: productId,
          name: event.name,
          codes: event.codes,
        );
      } else {
        _repository.createProduct(
          name: event.name,
          codes: event.codes,
        );
      }
      _navigationManager.pop();
    } catch (_) {}
  }

  @override
  Future<void> close() {
    super.stop();
    return super.close();
  }
}
