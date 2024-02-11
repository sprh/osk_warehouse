part of 'warehouse_list_bloc.dart';

sealed class WarehouseListEvent {}

class WarehouseListEventOnCreateWarehouseTap implements WarehouseListEvent {}

class WarehouseListEventOpenProductsList implements WarehouseListEvent {
  final String warehouseId;

  const WarehouseListEventOpenProductsList({
    required this.warehouseId,
  });
}

class WarehouseListEventInitialize implements WarehouseListEvent {}

class _WarehouseListUpdateStateEvent implements WarehouseListEvent {
  final List<Warehouse> warehouses;

  const _WarehouseListUpdateStateEvent(this.warehouses);
}

class _WarehouseListUpdateLoadingStateEvent implements WarehouseListEvent {
  final bool loading;

  const _WarehouseListUpdateLoadingStateEvent(this.loading);
}
