part of 'bloc.dart';

sealed class UserDataPageEvent {}

class UserDataPageEventInitialize implements UserDataPageEvent {}

class _UserDataPageEventSetLoading implements UserDataPageEvent {
  final bool loading;

  const _UserDataPageEventSetLoading(this.loading);
}

class _UserDataPageEventSetData implements UserDataPageEvent {
  final User? user;
  final List<Warehouse> warehouses;

  const _UserDataPageEventSetData({
    required this.user,
    required this.warehouses,
  });
}

class UserDataPageEventAddOrUpdateUser implements UserDataPageEvent {
  final String username;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final Set<Warehouse> warehouses;
  final Set<UserAccessTypes> accessTypes;
  final String password;

  const UserDataPageEventAddOrUpdateUser({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.warehouses,
    required this.accessTypes,
    required this.password,
  });
}
