import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
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
    String? productId,
  ) =>
      _ProductDataBloc(
        navigationManager,
        repository,
        refresher,
        productId: productId,
      );

  void stop();
}

class _ProductDataBloc extends Bloc<ProductDataPageEvent, ProductDataState>
    with RepositorySubscriber<(Product?, List<Warehouse>)>
    implements ProductDataBloc {
  final AccountScopeNavigationManager _navigationManager;
  final ProductRepository _repository;
  final String? productId;
  final ProductListRefresher _refresher;

  _ProductDataBloc(
    this._navigationManager,
    this._repository,
    this._refresher, {
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
        emit(ProductDataStateInitial());
        _repository.start();
        start();
        await _repository.refreshData(productId);
      case _ProductDataPageEventSetLoading():
        _maybeSetLoading(event.loading, emit);
      case _ProductDataPageEventSetData():
        _setData(event.product, emit);
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
          ProductDataStateUpdate(
            product: state.product,
            loading: loading,
            barcodes: state.barcodes,
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

  Future<void> _scanBarcode(Emitter<ProductDataState> emit) async {
    const permission = Permission.camera;
    if (!await permission.isGranted) {
      await permission.request();
      if (!await permission.isGranted) {
        await _navigationManager.showSomethingWentWrontDialog(
          'Чтобы отсканировать штрихкод, дайте доступ к камере в настройках',
        );
        return;
      }
    }

    final result = await FlutterBarcodeScanner.scanBarcode(
      '#000000',
      'Отмена',
      true,
      ScanMode.BARCODE,
    );

    if (result != '-1') {
      final state = this.state;

      switch (state) {
        case ProductDataStateInitial():
          break;
        case ProductDataStateUpdate():
          final barcodes = {...state.barcodes, result};

          emit(
            ProductDataStateUpdate(
              barcodes: barcodes,
              product: state.product,
            ),
          );
        case ProductDataStateCreate():
          final barcodes = {...state.barcodes, result};

          emit(
            ProductDataStateCreate(
              barcodes: barcodes,
            ),
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
          ProductDataStateUpdate(
            barcodes: barcodes,
            product: state.product,
          ),
        );
      case ProductDataStateCreate():
        final barcodes =
            state.barcodes.where((barcode) => barcode != id).toSet();

        emit(
          ProductDataStateCreate(
            barcodes: barcodes,
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
        ProductDataStateUpdate(
          product: product,
          barcodes: product.codes.toSet(),
        ),
      );
    } else {
      emit(const ProductDataStateCreate());
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
