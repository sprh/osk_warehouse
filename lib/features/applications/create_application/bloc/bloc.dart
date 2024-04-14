import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../../products/models/product.dart';
import '../../../warehouse/data/repository.dart';
import '../../../warehouse/models/warehouse.dart';
import '../../data/repository/create_application_repository.dart';
import '../../models/create_application/create_application_application_type.dart';
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

  CreateApplicationApplicationType get _applicationType =>
      (state as CreateApplicationStateData).type!;

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
        _onTypeSelected(event.type, emit);
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
      case CreateApplicationEventShowPreviousStep():
        _onShowPreviousStepEvent(emit);
    }
  }

  Future<void> _initialize(Emitter<CreateApplicationState> emit) async {
    final warehouses = await _warehouseListGetter.warehouseList;

    if (warehouses.isNotEmpty) {
      emit(
        CreateApplicationStateData(
          availableWarehouses: warehouses,
          step: CreateApplicationStepSelectType(),
        ),
      );
    } else {
      await _navigationManager.showSomethingWentWrontDialog(
        'Нет доступных складов. Попробуйте позже или обратитесь к администратору.',
      );
      _navigationManager.pop();
    }
  }

  void _onTypeSelected(
    CreateApplicationApplicationType type,
    Emitter<CreateApplicationState> emit,
  ) {
    final state = this.state as CreateApplicationStateData;
    final CreateApplicationStep step;
    switch (type) {
      case CreateApplicationApplicationType.send:
      case CreateApplicationApplicationType.recieve:
        step = CreateApplicationStepSelectToWarehouse();
      case CreateApplicationApplicationType.defect:
      case CreateApplicationApplicationType.use:
        step = const CreateApplicationStepSelectFromWarehouse(false);
    }

    emit(state.copyWith(step: step, type: type));
  }

  void _onToWarehouseSelected(
    Emitter<CreateApplicationState> emit,
    Warehouse warehouse,
  ) {
    final state = this.state as CreateApplicationStateData;
    final applicationType = _applicationType;
    final CreateApplicationStep step;

    switch (applicationType) {
      case CreateApplicationApplicationType.send:
        step = const CreateApplicationStepSelectFromWarehouse(false);
      case CreateApplicationApplicationType.recieve:
        step = const CreateApplicationStepSelectFromWarehouse(true);
      case CreateApplicationApplicationType.defect:
      case CreateApplicationApplicationType.use:
        throw StateError(
          'To warehouse should not be selected for $_applicationType',
        );
    }

    emit(
      state.copyWith(
        step: step,
        toWarehouse: warehouse,
        fromWarehouse: warehouse.id == state.fromWarehouse?.id
            ? null
            : state.fromWarehouse,
      ),
    );
  }

  void _onFromWarehouseSelected(
    Emitter<CreateApplicationState> emit,
    Warehouse? warehouse,
  ) {
    final state = this.state as CreateApplicationStateData;

    if (state.fromWarehouse != null &&
        warehouse?.id != state.fromWarehouse?.id) {
      emit(
        state.copyWith(
          step: CreateApplicationStepSelectProducts(),
          fromWarehouse: warehouse,
          selectedProducts: [],
        ),
      );
    } else {
      emit(
        state.copyWith(
          step: CreateApplicationStepSelectProducts(),
          fromWarehouse: warehouse,
        ),
      );
    }
  }

  void _onSelectProducts() {
    final id = (state as CreateApplicationStateData).fromWarehouse?.id;

    _navigationManager.onSelectProducts(
      (products) => add(
        _CreateApplicationEventProductsSelected(products: products),
      ),
      id,
      (state as CreateApplicationStateData)
          .selectedProducts
          ?.map((product) => product.product.id)
          .toSet(),
    );
  }

  void _onProductsSelected(
    List<Product> products,
    Emitter<CreateApplicationState> emit,
  ) {
    final state = this.state as CreateApplicationStateData;
    final selectedProducts = products.map(
      (product) => OskCreateApplicationProduct(
        product: product,
        count: 1,
        // Тут используется количество на складе как максимальное количество
        maxCount: product.count,
      ),
    );

    emit(
      state.copyWith(
        selectedProducts: selectedProducts.toList(),
      ),
    );
  }

  void _removeProduct(
    String id,
    Emitter<CreateApplicationState> emit,
  ) {
    final state = this.state as CreateApplicationStateData;
    final selectedProducts = state.selectedProducts
        ?.where((product) => product.product.id != id)
        .toList();

    emit(
      state.copyWith(
        selectedProducts: selectedProducts?.toList(),
      ),
    );
  }

  void _changeProductCount(
    String id,
    int count,
    Emitter<CreateApplicationState> emit,
  ) {
    final state = this.state as CreateApplicationStateData;
    final selectedProducts = state.selectedProducts?.map(
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
      state.copyWith(
        selectedProducts: selectedProducts?.toList(),
      ),
    );
  }

  void _onShowFinalScreen(Emitter<CreateApplicationState> emit) {
    final state = this.state as CreateApplicationStateData;
    emit(
      state.copyWith(
        step: CreateApplicationStepSave(),
      ),
    );
  }

  Future<void> _onCreateApplication(
    String description,
    Emitter<CreateApplicationState> emit,
  ) async {
    final state = this.state as CreateApplicationStateData;
    emit(state.copyWith(loading: true));

    try {
      final id = await _repository.createApplication(
        description: description,
        type: state.type!,
        sentFromWarehouseId: state.fromWarehouse?.id,
        sentToWarehouseId: state.toWarehouse?.id,
        linkedToApplicationId: null,
        items: state.selectedProducts ?? [],
      );
      _navigationManager
        ..pop()
        ..openApplicationData(id);
      // ignore: avoid_catching_errors
    } on RepositoryLocalizedError catch (e) {
      emit(state.copyWith(loading: false));
      await _navigationManager.showSomethingWentWrontDialog(e.message);
    }
  }

  void _onShowPreviousStepEvent(
    Emitter<CreateApplicationState> emit,
  ) {
    final state = this.state as CreateApplicationStateData;

    emit(state.onShowPreviousStep());
  }
}
