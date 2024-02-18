import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

mixin CurrentUsernameHolder {
  String? get currentUserUsername;
}

class AuthorizationDataBloc extends BlocBase<AuthorizationDataState>
    with CurrentUsernameHolder {
  AuthorizationDataBloc() : super(NotAuthorizedState());

  @override
  String? get currentUserUsername {
    final state = this.state;

    switch (state) {
      case AuthorizedState():
        return state.username;
      case NotAuthorizedState():
        return null;
    }
  }

  void setAuthorized({required String username}) => emit(
        AuthorizedState(username),
      );

  void setNotAuthorized() => emit(NotAuthorizedState());
}
