import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import 'requests_list_events.dart';

abstract class RequestsListBloc extends Bloc<RequestsListEvent, dynamic> {
  static RequestsListBloc of(BuildContext context) => BlocProvider.of(context);

  factory RequestsListBloc(AccountScopeNavigationManager navigationManager) =>
      _RequestsListBloc(navigationManager);
}

class _RequestsListBloc extends Bloc<RequestsListEvent, dynamic>
    implements RequestsListBloc {
  final AccountScopeNavigationManager _navigationManager;

  _RequestsListBloc(this._navigationManager) : super(null) {
    on<RequestsListEvent>(_onEvent);
  }

  void _onEvent(RequestsListEvent event, Emitter<dynamic> emit) {
    switch (event) {
      case RequestsListEventOpenRequestInfo():
        _navigationManager.openRequestInfoPage(event.requestId);
    }
  }
}
