import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../../products/models/product.dart';
import '../../../warehouse/data/repository.dart';
import '../../../warehouse/models/warehouse.dart';
import '../../data/repository/create_application_repository.dart';
import '../../models/osk_appication_type.dart';
import '../../models/osk_create_application_product.dart';

part 'event.dart';
part 'state.dart';

abstract class CreateApplicationBloc
    extends Bloc<CreateApplicationEvent, CreateApplicationState> {
  static CreateApplicationBloc of(BuildContext context) =>
      BlocProvider.of(context);

  factory CreateApplicationBloc(
    WarehouseListGetter warehouseListGetter,
    AccountScopeNavigationManager navigationManager,
    CreateApplicationRepository repository,
  ) =>
      _CreateApplicationBloc(
        warehouseListGetter,
        navigationManager,
        repository,
      );
}

class _CreateApplicationBloc
    extends Bloc<CreateApplicationEvent, CreateApplicationState>
    implements CreateApplicationBloc {
  final WarehouseListGetter _warehouseListGetter;
  final AccountScopeNavigationManager _navigationManager;
  final CreateApplicationRepository _repository;

  _CreateApplicationBloc(
    this._warehouseListGetter,
    this._navigationManager,
    this._repository,
  ) : super(CreateApplicationStateIdle()) {
    on<CreateApplicationEvent>(_onEvent);
  }

  OskApplicationType? get _applicationType {
    final state = this.state;
    switch (state) {
      case CreateApplicationStateIdle():
        return null;
      case CreateApplicationStateSelectType():
        return null;
      case CreateApplicationStateSelectToWarehouse():
        return state.type;
      case CreateApplicationStateSelectFromWarehouse():
        return state.type;
      case CreateApplicationStateSelectProducts():
        return state.type;
      case CreateApplicationStateFinal():
        return state.type;
    }
  }

  List<Warehouse>? get _availableWarehouses {
    final state = this.state;

    switch (state) {
      case CreateApplicationStateIdle():
        return null;
      case CreateApplicationStateSelectType():
        return state.availableWarehouses;
      case CreateApplicationStateSelectToWarehouse():
        return state.availableWarehouses;
      case CreateApplicationStateSelectFromWarehouse():
        return state.availableWarehouses;
      case CreateApplicationStateSelectProducts():
        return state.availableWarehouses;
      case CreateApplicationStateFinal():
        return state.availableWarehouses;
    }
  }

  Future<void> _onEvent(
    CreateApplicationEvent event,
    Emitter<CreateApplicationState> emit,
  ) async {
    switch (event) {
      case CreateApplicationEventInitialize():
        await _initialize(emit);
      case CreateApplicationEventSelectProductsButtonTap():
        _onSelectProducts();
      case _CreateApplicationEventProductsSelected():
        _onProductsSelected(event.products, emit);
      case CreateApplicationEventOnTypeSelected():
        emit(
          CreateApplicationStateSelectToWarehouse(
            (state as CreateApplicationStateSelectType).availableWarehouses,
            event.type,
          ),
        );
      case CreateApplicationEventOnToWarehouseSelected():
        _onToWarehouseSelected(emit, event.warehouse);
      case CreateApplicationEventOnFromWarehouseSelected():
        _onFromWarehouseSelected(emit, event.warehouse);
      case CreateApplicationEventRemoveProduct():
        _removeProduct(event.id, emit);
      case CreateApplicationEventChangeCount():
        _changeProductCount(event.id, event.count, emit);
      case CreateApplicationEventOnShowFinalScreen():
        _onShowFinalScreen(emit);
      case CreateApplicationCreateButtonTap():
        await _onCreateApplication(event.description, emit);
    }
  }

  Future<void> _initialize(Emitter<CreateApplicationState> emit) async {
    final warehouses = await _warehouseListGetter.warehouseList;

    if (warehouses.isNotEmpty) {
      emit(CreateApplicationStateSelectType(warehouses));
    } else {
      await _navigationManager.showSomethingWentWrontDialog(
        'Нет доступных складов. Попробуйте позже или обратитесь к администратору.',
      );
      _navigationManager.pop();
    }
  }

  void _onToWarehouseSelected(
    Emitter<CreateApplicationState> emit,
    Warehouse warehouse,
  ) {
    final availableWarehouses = _availableWarehouses;
    final applicationType = _applicationType;
    if (availableWarehouses == null || applicationType == null) {
      return;
    }

    switch (_applicationType) {
      case OskApplicationType.send:
        emit(
          CreateApplicationStateSelectFromWarehouse(
            toWarehouse: warehouse,
            canBeSkipped: false,
            availableWarehouses: availableWarehouses,
            type: applicationType,
          ),
        );
      case OskApplicationType.recieve:
        emit(
          CreateApplicationStateSelectFromWarehouse(
            toWarehouse: warehouse,
            canBeSkipped: true,
            availableWarehouses: availableWarehouses,
            type: applicationType,
          ),
        );
      case OskApplicationType.defect:
      case OskApplicationType.use:
      case OskApplicationType.revert:
      case null:
        emit(
          CreateApplicationStateSelectProducts(
            toWarehouse: warehouse,
            fromWarehouse: null,
            selectedProducts: [],
            availableWarehouses: availableWarehouses,
            type: applicationType,
          ),
        );
    }
  }

  void _onFromWarehouseSelected(
    Emitter<CreateApplicationState> emit,
    Warehouse? warehouse,
  ) {
    final availableWarehouses = _availableWarehouses;
    final applicationType = _applicationType;
    if (availableWarehouses == null || applicationType == null) {
      return;
    }

    emit(
      CreateApplicationStateSelectProducts(
        toWarehouse:
            (state as CreateApplicationStateSelectFromWarehouse).toWarehouse,
        fromWarehouse: warehouse,
        selectedProducts: [],
        availableWarehouses: availableWarehouses,
        type: applicationType,
      ),
    );
  }

  void _onSelectProducts() {
    late final String? warehouseId;
    final firstWarehouseId =
        (state as CreateApplicationStateSelectProducts).toWarehouse.id;

    switch (_applicationType) {
      case OskApplicationType.recieve:
        // Приемка со склада на склад
        if ((state as CreateApplicationStateSelectProducts).fromWarehouse !=
            null) {
          warehouseId = firstWarehouseId;
        } else {
          warehouseId = null;
        }
      case null:
      case OskApplicationType.send:
      case OskApplicationType.defect:
      case OskApplicationType.use:
      case OskApplicationType.revert:
        warehouseId = firstWarehouseId;
    }

    _navigationManager.onSelectProducts(
      (products) => add(
        _CreateApplicationEventProductsSelected(products: products),
      ),
      warehouseId,
      (state as CreateApplicationStateSelectProducts)
          .selectedProducts
          .map((product) => product.product.id)
          .toSet(),
    );
  }

  void _onProductsSelected(
    List<Product> products,
    Emitter<CreateApplicationState> emit,
  ) {
    final state = this.state as CreateApplicationStateSelectProducts;
    final selectedProducts = products.map(
      (product) => OskCreateApplicationProduct(
        product: product,
        count: 1,
        // Тут используется количество на складе как максимальное количество
        maxCount: product.count,
      ),
    );

    emit(
      CreateApplicationStateSelectProducts(
        availableWarehouses: state.availableWarehouses,
        toWarehouse: state.toWarehouse,
        fromWarehouse: state.fromWarehouse,
        selectedProducts: selectedProducts.toList(),
        type: state.type,
      ),
    );
  }

  void _removeProduct(
    String id,
    Emitter<CreateApplicationState> emit,
  ) {
    final state = this.state as CreateApplicationStateSelectProducts;
    final selectedProducts = state.selectedProducts
        .where((product) => product.product.id != id)
        .toList();

    emit(
      CreateApplicationStateSelectProducts(
        availableWarehouses: state.availableWarehouses,
        toWarehouse: state.toWarehouse,
        fromWarehouse: state.fromWarehouse,
        selectedProducts: selectedProducts.toList(),
        type: state.type,
      ),
    );
  }

  void _changeProductCount(
    String id,
    int count,
    Emitter<CreateApplicationState> emit,
  ) {
    final state = this.state as CreateApplicationStateSelectProducts;
    final selectedProducts = state.selectedProducts.map(
      (product) {
        if (product.product.id == id) {
          return OskCreateApplicationProduct(
            product: product.product,
            count: count,
            maxCount: product.maxCount,
          );
        }
        return product;
      },
    );
    emit(
      CreateApplicationStateSelectProducts(
        availableWarehouses: state.availableWarehouses,
        toWarehouse: state.toWarehouse,
        fromWarehouse: state.fromWarehouse,
        selectedProducts: selectedProducts.toList(),
        type: state.type,
      ),
    );
  }

  void _onShowFinalScreen(Emitter<CreateApplicationState> emit) {
    final state = this.state as CreateApplicationStateSelectProducts;
    emit(
      CreateApplicationStateFinal(
        availableWarehouses: state.availableWarehouses,
        toWarehouse: state.toWarehouse,
        fromWarehouse: state.fromWarehouse,
        selectedProducts: state.selectedProducts,
        type: state.type,
      ),
    );
  }

  Future<void> _onCreateApplication(
    String description,
    Emitter<CreateApplicationState> emit,
  ) async {
    final state = this.state as CreateApplicationStateFinal;
    emit(state.copyWith(loading: true));

    try {
      await _repository.createApplication(
        description: description,
        type: state.type,
        sentFromWarehouseId: state.fromWarehouse?.id,
        sentToWarehouseId: state.toWarehouse.id,
        linkedToApplicationId: null,
        items: state.selectedProducts,
      );
      _navigationManager.pop();
      // ignore: avoid_catching_errors
    } on RepositoryLocalizedError catch (e) {
      emit(state.copyWith(loading: false));
      await _navigationManager.showSomethingWentWrontDialog(e.message);
    }
  }
}
