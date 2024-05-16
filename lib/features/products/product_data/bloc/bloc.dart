import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../../barcode/barcode_scanner.dart';
import '../../../user/current_user_holder/current_user_holder.dart';
import '../../../warehouse/models/warehouse.dart';
import '../../data/product_list_repository.dart';
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
    ProductListRefresher refresher,
    CurrentUserHolder currentUserHolder,
    BarcodeScanner barcodeScanner,
    String? productId, {
    required bool canEdit,
  }) = _ProductDataBloc;

  void stop();
}

class _ProductDataBloc extends Bloc<ProductDataPageEvent, ProductDataState>
    with RepositorySubscriber<(Product?, List<Warehouse>)>
    implements ProductDataBloc {
  final AccountScopeNavigationManager _navigationManager;
  final ProductRepository _repository;
  final String? productId;
  final ProductListRefresher _refresher;
  final CurrentUserHolder _currentUserHolder;
  final BarcodeScanner _barcodeScanner;
  final bool canEdit;
  _ProductDataBloc(
    this._navigationManager,
    this._repository,
    this._refresher,
    this._currentUserHolder,
    this._barcodeScanner,
    this.productId, {
    required this.canEdit,
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
        emit(ProductDataStateInitial());
        _repository.start();
        start();
        await _repository.refreshData(productId);
      case _ProductDataPageEventSetLoading():
        _maybeSetLoading(event.loading, emit);
      case _ProductDataPageEventSetData():
        await _setData(event.product, emit);
      case ProductDataPageEventAddOrUpdateProduct():
        await _addOrUpdateProduct(event);
      case ProductDataPageEventScanBarcode():
        await _scanBarcode(emit);
      case ProductDataPageEventDeleteBarcode():
        _deleteBarcode(emit, event.id);
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
          state.copyWith(loading: loading),
        );
      case ProductDataStateCreate():
        emit(
          state.copyWith(loading: loading),
        );
    }
  }

  Future<void> _scanBarcode(Emitter<ProductDataState> emit) async {
    final barcode = await _barcodeScanner.scanBarcode();

    if (barcode != null) {
      final state = this.state;

      switch (state) {
        case ProductDataStateInitial():
          break;
        case ProductDataStateUpdate():
          final barcodes = {...state.barcodes, barcode};

          emit(
            state.copyWith(
              barcodes: barcodes,
            ),
          );
        case ProductDataStateCreate():
          final barcodes = {...state.barcodes, barcode};

          emit(
            state.copyWith(barcodes: barcodes),
          );
      }
    }
  }

  void _deleteBarcode(Emitter<ProductDataState> emit, String id) {
    final state = this.state;

    switch (state) {
      case ProductDataStateInitial():
        break;
      case ProductDataStateUpdate():
        final barcodes =
            state.barcodes.where((barcode) => barcode != id).toSet();

        emit(
          state.copyWith(barcodes: barcodes),
        );
      case ProductDataStateCreate():
        final barcodes =
            state.barcodes.where((barcode) => barcode != id).toSet();

        emit(
          state.copyWith(barcodes: barcodes),
        );
    }
  }

  Future<void> _setData(
    Product? product,
    // List<Warehouse> warehouses,
    Emitter<ProductDataState> emit,
  ) async {
    final currentUser = await _currentUserHolder.currentUser;

    if (product != null) {
      emit(
        ProductDataStateUpdate(
          product: product,
          barcodes: product.codes.toSet(),
          showUpdateProductButton: currentUser.canManagerProducts && canEdit,
        ),
      );
    } else {
      emit(
        ProductDataStateCreate(
          showUpdateProductButton: currentUser.canManagerProducts && canEdit,
        ),
      );
    }
  }

  Future<void> _addOrUpdateProduct(
    ProductDataPageEventAddOrUpdateProduct event,
  ) async {
    final productId = this.productId;
    try {
      if (productId != null) {
        await _repository.updateProduct(
          id: productId,
          itemName: event.name,
          codes: event.codes.toList(),
          itemType: event.itemType?.name ?? ProductType.other.name,
          manufacturer: event.manufacturer,
          model: event.model,
          description: event.description,
        );
      } else {
        await _repository.createProduct(
          itemName: event.name,
          codes: event.codes.toList(),
          itemType: event.itemType?.name ?? ProductType.other.name,
          manufacturer: event.manufacturer,
          model: event.model,
          description: event.description,
        );
      }
      _refresher.refreshData();
      _navigationManager.pop();
    } catch (_) {}
  }

  @override
  Future<void> close() {
    super.stop();
    return super.close();
  }
}
