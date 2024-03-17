part of 'bloc.dart';

sealed class CreateApplicationState {}

class CreateApplicationStateIdle implements CreateApplicationState {}

class CreateApplicationStateSelectType implements CreateApplicationState {
  final List<Warehouse> availableWarehouses;

  const CreateApplicationStateSelectType(this.availableWarehouses);
}

class CreateApplicationStateSelectToWarehouse
    implements CreateApplicationState {
  final ApplicationType type;
  final List<Warehouse> availableWarehouses;

  const CreateApplicationStateSelectToWarehouse(
    this.availableWarehouses,
    this.type,
  );
}

class CreateApplicationStateSelectFromWarehouse
    implements CreateApplicationState {
  final List<Warehouse> availableWarehouses;
  final ApplicationType type;

  final Warehouse toWarehouse;
  final bool canBeSkipped;

  const CreateApplicationStateSelectFromWarehouse({
    required this.toWarehouse,
    required this.canBeSkipped,
    required this.availableWarehouses,
    required this.type,
  });
}

class CreateApplicationStateSelectProducts implements CreateApplicationState {
  final List<Warehouse> availableWarehouses;
  final ApplicationType type;
  final Warehouse toWarehouse;
  final Warehouse? fromWarehouse;
  final List<OskCreateApplicationProduct> selectedProducts;

  CreateApplicationStateSelectProducts({
    required this.toWarehouse,
    required this.fromWarehouse,
    required this.selectedProducts,
    required this.availableWarehouses,
    required this.type,
  });
}

class CreateApplicationStateFinal implements CreateApplicationState {
  final List<Warehouse> availableWarehouses;
  final ApplicationType type;
  final Warehouse toWarehouse;
  final Warehouse? fromWarehouse;
  final List<OskCreateApplicationProduct> selectedProducts;
  final bool loading;

  CreateApplicationStateFinal({
    required this.toWarehouse,
    required this.fromWarehouse,
    required this.selectedProducts,
    required this.availableWarehouses,
    required this.type,
    this.loading = false,
  });

  CreateApplicationStateFinal copyWith({
    bool? loading,
  }) {
    return CreateApplicationStateFinal(
      loading: loading ?? this.loading,
      toWarehouse: toWarehouse,
      fromWarehouse: fromWarehouse,
      selectedProducts: selectedProducts,
      availableWarehouses: availableWarehouses,
      type: type,
    );
  }
}
