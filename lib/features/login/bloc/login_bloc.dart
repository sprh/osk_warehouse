import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/actions/actions_flex.dart';
import '../../../common/components/button/osk_button.dart';
import '../../../core/authorization/data/manager.dart';
import '../../../core/navigation/manager/app_scope_navigation_manager.dart';
import 'login_events.dart';
import 'login_page_state.dart';

abstract class LoginBloc extends Bloc<LoginEvent, LoginPageState> {
  static LoginBloc of(BuildContext context) => BlocProvider.of(context);

  factory LoginBloc(
    AppScopeNavigationManager navigationManager,
    AuthorizationDataManager authorizationDataManager,
  ) =>
      _LoginBloc(
        navigationManager,
        authorizationDataManager,
      );
}

class _LoginBloc extends Bloc<LoginEvent, LoginPageState> implements LoginBloc {
  final AppScopeNavigationManager _navigationManager;
  final AuthorizationDataManager _authorizationDataManager;

  _LoginBloc(this._navigationManager, this._authorizationDataManager)
      : super(LoginPageStateDefault()) {
    on<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent(LoginEvent event, Emitter<dynamic> emit) async {
    switch (event) {
      case LoginEventButtonSignInTap():
        await _tryAuthorize(event.username, event.password, emit);
    }
  }

  Future<void> _tryAuthorize(
    String username,
    String password,
    Emitter<dynamic> emit,
  ) async {
    if (state is LoginPageStateLoading) {
      return;
    }

    emit(LoginPageStateLoading());
    try {
      await _authorizationDataManager.getToken(
        username: username,
        password: password,
      );
    } on Object {
      await _navigationManager.showModalDialog(
        title: 'Не удалось авторизироваться',
        subtitle: 'Проверьте правильность введенных данных',
        actions: OskActionsFlex(
          widgets: [
            OskButton.main(
              title: 'Хорошо',
              onTap: _navigationManager.popDialog,
            ),
          ],
        ),
      );
    } finally {
      emit(LoginPageStateDefault());
    }
  }
}
