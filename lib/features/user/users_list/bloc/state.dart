import '../../models/user.dart';

sealed class UserListState {}

class UserListInitialState implements UserListState {}

class UserListDataState implements UserListState {
  final List<User> users;
  final bool loading;

  const UserListDataState(this.users, {this.loading = false});

  UserListDataState copyWith({
    List<User>? users,
    bool? loading,
  }) =>
      UserListDataState(users ?? this.users, loading: loading ?? this.loading);
}
