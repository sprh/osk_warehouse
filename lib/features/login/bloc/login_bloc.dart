import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/authorization/data/manager.dart';
import '../../navigation/logic/navigation_manager.dart';
import 'login_events.dart';

abstract class LoginBloc extends Bloc<LoginEvent, dynamic> {
  static LoginBloc of(BuildContext context) => BlocProvider.of(context);

  factory LoginBloc(
    NavigationManager navigationManager,
    AuthorizationDataManager authorizationDataManager,
  ) =>
      _LoginBloc(
        navigationManager,
        authorizationDataManager,
      );
}

class _LoginBloc extends Bloc<LoginEvent, dynamic> implements LoginBloc {
  final NavigationManager _navigationManager;
  final AuthorizationDataManager _authorizationDataManager;

  _LoginBloc(this._navigationManager, this._authorizationDataManager)
      : super(null) {
    on<LoginEvent>(_onEvent);
  }

  void _onEvent(LoginEvent event, Emitter<dynamic> emit) {
    switch (event) {
      case LoginEventButtonSignInTap():
        _authorize(event.username, event.password);

      // _navigationManager.openMain();
    }
  }

  Future<void> _authorize(String username, String password) async {
    await _authorizationDataManager.getToken(
      username: username,
      password: password,
    );
  }
}
