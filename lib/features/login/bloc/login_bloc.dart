import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/actions/actions_flex.dart';
import '../../../components/button/osk_button.dart';
import '../../../core/authorization/data/manager.dart';
import '../../navigation/logic/navigation_manager.dart';
import 'login_events.dart';
import 'login_page_state.dart';

abstract class LoginBloc extends Bloc<LoginEvent, LoginPageState> {
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

class _LoginBloc extends Bloc<LoginEvent, LoginPageState> implements LoginBloc {
  final NavigationManager _navigationManager;
  final AuthorizationDataManager _authorizationDataManager;

  _LoginBloc(this._navigationManager, this._authorizationDataManager)
      : super(LoginPageStateDefault()) {
    on<LoginEvent>(_onEvent);
  }

  void _onEvent(LoginEvent event, Emitter<dynamic> emit) {
    switch (event) {
      case LoginEventButtonSignInTap():
        _tryAuthorize(event.username, event.password);
    }
  }

  Future<void> _tryAuthorize(String username, String password) async {
    final tokenData = await _authorizationDataManager.getToken(
      username: username,
      password: password,
    );

    if (tokenData) {
      _navigationManager.openMain();
    } else {
      // TODO: translate
      _navigationManager.showModalDialog(
        title: 'Не удалось авторизироваться',
        subtitle: 'Проверьте правильность введенных данных',
        actions: OskActionsFlex(
          widgets: [
            OskButton.main(
              title: 'Хорошо',
              onTap: _navigationManager.pop,
            ),
          ],
        ),
      );
    }
  }
}
