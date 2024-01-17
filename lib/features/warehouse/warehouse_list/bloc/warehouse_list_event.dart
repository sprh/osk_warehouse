sealed class WarehouseListEvent {}

class WarehouseListEventOnCreateWarehouseTap implements WarehouseListEvent {}

class WarehouseListEventOpenProductsList implements WarehouseListEvent {
  final String warehouseId;

  const WarehouseListEventOpenProductsList({
    required this.warehouseId,
  });
}
