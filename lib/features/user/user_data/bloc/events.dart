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
