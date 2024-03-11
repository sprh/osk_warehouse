import '../../models/warehouse.dart';

sealed class WarehouseListState {}

class WarehouseListIdleState implements WarehouseListState {}

class WarehouseListDataState implements WarehouseListState {
  final List<Warehouse> items;
  final bool loading;
  // Может ли добавлять, удалять или редактировать склады
  final bool canEditData;

  const WarehouseListDataState({
    required this.items,
    required this.canEditData,
    this.loading = false,
  });

  WarehouseListDataState copyWith({
    List<Warehouse>? items,
    bool? loading,
  }) =>
      WarehouseListDataState(
        items: items ?? this.items,
        loading: loading ?? this.loading,
        canEditData: canEditData,
      );
}
