part of 'bloc.dart';

sealed class CreateApplicationState {}

class CreateApplicationStateIdle implements CreateApplicationState {}

class CreateApplicationStateData implements CreateApplicationState {
  final List<Warehouse> availableWarehouses;

  final CreateApplicationStep step;
  final List<CreateApplicationStep> previousStep;

  final CreateApplicationApplicationType? type;
  final Warehouse? toWarehouse;
  final Warehouse? fromWarehouse;
  final List<OskCreateApplicationProduct>? selectedProducts;
  final bool loading;

  const CreateApplicationStateData({
    required this.availableWarehouses,
    required this.step,
    this.previousStep = const <CreateApplicationStep>[],
    this.type,
    this.toWarehouse,
    this.fromWarehouse,
    this.selectedProducts,
    this.loading = false,
  });

  CreateApplicationStateData copyWith({
    CreateApplicationStep? step,
    CreateApplicationApplicationType? type,
    Warehouse? toWarehouse,
    Warehouse? fromWarehouse,
    List<OskCreateApplicationProduct>? selectedProducts,
    bool? loading,
  }) =>
      CreateApplicationStateData(
        step: step ?? this.step,
        previousStep: [...previousStep, this.step],
        type: type ?? this.type,
        toWarehouse: toWarehouse ?? this.toWarehouse,
        fromWarehouse: fromWarehouse ?? this.fromWarehouse,
        selectedProducts: selectedProducts ?? this.selectedProducts,
        loading: loading ?? this.loading,
        availableWarehouses: availableWarehouses,
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
      );

  bool get canGoBack => previousStep.isNotEmpty;
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

class CreateApplicationStepSelectProducts implements CreateApplicationStep {}

class CreateApplicationStepSave implements CreateApplicationStep {}
