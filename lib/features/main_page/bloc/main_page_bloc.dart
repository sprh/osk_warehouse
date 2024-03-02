import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/manager/account_scope_navigation_manager.dart';
import 'main_page_event.dart';

abstract class MainPageBloc extends Bloc<MainPageEvent, dynamic> {
  static MainPageBloc of(BuildContext context) => BlocProvider.of(context);

  factory MainPageBloc(AccountScopeNavigationManager navigationManager) =>
      _MainPageBloc(
        navigationManager,
      );
}

class _MainPageBloc extends Bloc<MainPageEvent, dynamic>
    implements MainPageBloc {
  final AccountScopeNavigationManager _navigationManager;

  _MainPageBloc(this._navigationManager) : super(null) {
    on<MainPageEvent>(_onEvent);
  }

  void _onEvent(MainPageEvent event, Emitter<dynamic> emit) {
    switch (event) {
      case MainPageEventOpenWorkersList():
        _navigationManager.openWorkersList();
      case MainPageEventOpenWarehouseList():
        _navigationManager.openWarehouseList();
      case MainPageEventOpenProductsList():
        _navigationManager.openProductsList();
      case MainPageEventOpenRequestsList():
        _navigationManager.openRequestsList();
    }
  }
}
