sealed class WarehouseDataState {}

class WarehouseDataStateInitial implements WarehouseDataState {}

class WarehouseDataStateNewWarehouse implements WarehouseDataState {
  final bool loading;

  const WarehouseDataStateNewWarehouse({this.loading = false});
}

class WarehouseDataStateUpdateWarehouse implements WarehouseDataState {
  final bool loading;
  final String name;
  final String address;
  // Может ли добавлять, удалять или редактировать склады
  final bool canEditData;

  const WarehouseDataStateUpdateWarehouse({
    required this.name,
    required this.address,
    required this.canEditData,
    this.loading = false,
  });
}
