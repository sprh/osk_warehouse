import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/logic/navigation_manager.dart';
import 'login_events.dart';

abstract class LoginBloc extends Bloc<LoginEvent, dynamic> {
  factory LoginBloc(NavigationManager navigationManager) => _LoginBloc(
        navigationManager,
      );
}

class _LoginBloc extends Bloc<LoginEvent, dynamic> implements LoginBloc {
  final NavigationManager _navigationManager;

  _LoginBloc(this._navigationManager) : super(null) {
    on<LoginEvent>(_onEvent);
  }

  void _onEvent(LoginEvent event, Emitter<dynamic> emit) {
    switch (event) {
      case LoginEventButtonSignInTap():
        _navigationManager.openMain();
        break;
    }
  }
}
