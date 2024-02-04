import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class AuthorizationDataBloc extends BlocBase<AuthorizationDataState> {
  AuthorizationDataBloc() : super(NotAuthorizedState());

  void setAuthorized() => emit(AuthorizedState());

  void setNotAuthorized() => emit(NotAuthorizedState());
}
