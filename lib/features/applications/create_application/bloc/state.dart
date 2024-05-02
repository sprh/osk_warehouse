part of 'bloc.dart';

// Mode
sealed class CreateApplicationMode {
  factory CreateApplicationMode.fromApplication(Application? application) {
    if (application == null) {
      return CreateApplicationModeCreate();
    } else {
      return CreateApplicationModeEdit(application: application);
    }
  }
}

class CreateApplicationModeCreate implements CreateApplicationMode {}

class CreateApplicationModeEdit implements CreateApplicationMode {
  final Application application;

  const CreateApplicationModeEdit({required this.application});
}

// State
sealed class CreateApplicationState {
  final CreateApplicationMode mode;

  const CreateApplicationState({required this.mode});
}

class CreateApplicationStateIdle extends CreateApplicationState {
  CreateApplicationStateIdle({required super.mode});
}

class CreateApplicationStateData extends CreateApplicationState {
  final List<Warehouse> availableWarehouses;

  final CreateApplicationStep step;
  final List<CreateApplicationStep> previousStep;

  final CreateApplicationApplicationType? type;
  final Warehouse? toWarehouse;
  final Warehouse? fromWarehouse;
  final List<OskCreateApplicationProduct>? selectedProducts;
  final String? description;
  final bool loading;

  const CreateApplicationStateData({
    required this.availableWarehouses,
    required this.step,
    required super.mode,
    this.previousStep = const <CreateApplicationStep>[],
    this.type,
    this.toWarehouse,
    this.fromWarehouse,
    this.selectedProducts,
    this.loading = false,
    this.description,
  });

  factory CreateApplicationStateData.fromApplication({
    required Application? application,
    required List<Warehouse> availableWarehouses,
    required CreateApplicationMode mode,
  }) {
    CreateApplicationApplicationType? type;

    switch (application?.data.type) {
      case null:
        type = null;
      case ApplicationType.send:
        type = CreateApplicationApplicationType.send;
      case ApplicationType.recieve:
        type = CreateApplicationApplicationType.recieve;
      case ApplicationType.defect:
        type = CreateApplicationApplicationType.defect;
      case ApplicationType.use:
        type = CreateApplicationApplicationType.use;
      case ApplicationType.revert:
        throw StateError('uknown type');
    }

    return CreateApplicationStateData(
      availableWarehouses: availableWarehouses,
      step: application == null
          ? CreateApplicationStepSelectType()
          : CreateApplicationStepSave(),
      mode: mode,
      type: type,
      toWarehouse: availableWarehouses.firstWhereOrNull(
        (warehouse) =>
            warehouse.name == application?.data.sentToWarehouse?.warehouseName,
      ),
      fromWarehouse: availableWarehouses.firstWhereOrNull(
        (warehouse) =>
            warehouse.name ==
            application?.data.sentFromWarehouse?.warehouseName,
      ),
      selectedProducts: application?.products
          .map(
            (product) => OskCreateApplicationProduct(
              count: product.count ?? 0,
              product: product,
            ),
          )
          .toList(),
      description: application?.data.description,
    );
  }

  CreateApplicationStateData copyWith({
    CreateApplicationStep? step,
    CreateApplicationApplicationType? type,
    Warehouse? toWarehouse,
    Warehouse? fromWarehouse,
    List<OskCreateApplicationProduct>? selectedProducts,
    bool? loading,
    String? description,
    bool updatePrevious = true,
  }) =>
      CreateApplicationStateData(
        mode: mode,
        step: step ?? this.step,
        previousStep:
            updatePrevious ? [...previousStep, this.step] : previousStep,
        type: type ?? this.type,
        toWarehouse: toWarehouse ?? this.toWarehouse,
        fromWarehouse: fromWarehouse ?? this.fromWarehouse,
        selectedProducts: selectedProducts ?? this.selectedProducts,
        loading: loading ?? this.loading,
        availableWarehouses: availableWarehouses,
        description: description ?? this.description,
      );

  CreateApplicationStateData onShowPreviousStep() => CreateApplicationStateData(
        step: previousStep.last,
        previousStep: previousStep.take(previousStep.length - 1).toList(),
        type: type,
        toWarehouse: toWarehouse,
        fromWarehouse: fromWarehouse,
        selectedProducts: selectedProducts,
        loading: loading,
        availableWarehouses: availableWarehouses,
        mode: mode,
        description: description,
      );

  bool get canGoBack {
    if (mode is CreateApplicationModeEdit &&
        previousStep.length == 1 &&
        previousStep.last is CreateApplicationStepSelectType) {
      return false;
    }

    return previousStep.isNotEmpty;
  }
}

// ---Steps---
sealed class CreateApplicationStep {}

class CreateApplicationStepSelectType implements CreateApplicationStep {}

class CreateApplicationStepSelectToWarehouse implements CreateApplicationStep {}

class CreateApplicationStepSelectFromWarehouse
    implements CreateApplicationStep {
  final bool canSkip;

  const CreateApplicationStepSelectFromWarehouse(this.canSkip);
}

class CreateApplicationStepSelectProducts implements CreateApplicationStep {
  final bool loading;

  const CreateApplicationStepSelectProducts({this.loading = false});
}

class CreateApplicationStepSave implements CreateApplicationStep {}
