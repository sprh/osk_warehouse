import '../../models/user.dart';

sealed class UserListState {}

class UserListInitialState implements UserListState {}

class UserListDataState implements UserListState {
  final List<User> users;
  final bool loading;
  // Может ли добавлять, удалять или редактировать пользователей
  final bool canEditData;

  const UserListDataState(
    this.users,
    this.canEditData, {
    this.loading = false,
  });

  UserListDataState copyWith({
    List<User>? users,
    bool? loading,
    bool? canEditData,
  }) =>
      UserListDataState(
        users ?? this.users,
        canEditData ?? this.canEditData,
        loading: loading ?? this.loading,
      );
}
