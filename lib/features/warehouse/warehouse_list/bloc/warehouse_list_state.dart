import '../../models/warehouse.dart';

sealed class WarehouseListState {}

class WarehouseListIdleState implements WarehouseListState {}

class WarehouseListDataState implements WarehouseListState {
  final List<Warehouse> items;
  final bool loading;

  const WarehouseListDataState({required this.items, this.loading = false});

  WarehouseListDataState copyWith({
    List<Warehouse>? items,
    bool? loading,
  }) =>
      WarehouseListDataState(
        items: items ?? this.items,
        loading: loading ?? this.loading,
      );
}
