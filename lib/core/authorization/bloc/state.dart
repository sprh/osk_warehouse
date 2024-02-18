sealed class AuthorizationDataState {}

class AuthorizedState implements AuthorizationDataState {
  final String username;

  const AuthorizedState(this.username);
}

class NotAuthorizedState implements AuthorizationDataState {}
