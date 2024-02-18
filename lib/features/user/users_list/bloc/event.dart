part of 'bloc.dart';

sealed class UserListEvent {}

class UserListEventInitialize implements UserListEvent {}

class UserListEventAddNewUser implements UserListEvent {}

class UserListEventDeleteUser implements UserListEvent {
  final String username;

  const UserListEventDeleteUser(this.username);
}

class _UserListUpdateStateEvent implements UserListEvent {
  final List<User>? users;
  final bool? loading;

  const _UserListUpdateStateEvent({this.users, this.loading});
}

class UserListUserTapEvent implements UserListEvent {
  final String username;

  const UserListUserTapEvent(this.username);
}
