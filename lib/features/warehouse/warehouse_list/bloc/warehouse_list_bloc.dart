import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/manager/navigation_manager.dart';
import 'warehouse_list_event.dart';

class WarehouseListBloc extends Bloc<WarehouseListEvent, dynamic> {
  static WarehouseListBloc of(BuildContext context) => BlocProvider.of(context);

  factory WarehouseListBloc(AccountScopeNavigationManager navigationManager) =>
      _WarehouseListBloc(navigationManager);
}

class _WarehouseListBloc extends Bloc<WarehouseListEvent, dynamic>
    implements WarehouseListBloc {
  final AccountScopeNavigationManager _navigationManager;

  _WarehouseListBloc(this._navigationManager) : super(null) {
    on<WarehouseListEvent>(_onEvent);
  }

  void _onEvent(WarehouseListEvent event, Emitter<dynamic> emit) {
    switch (event) {
      case WarehouseListEventOnCreateWarehouseTap():
        _navigationManager.openNewWarehouse();
      case WarehouseListEventOpenProductsList():
        _navigationManager.openProductsList(event.warehouseId);
    }
  }
}
