import '../../../warehouse/models/warehouse.dart';
import '../../models/user.dart';

sealed class UserDataState {}

class UserDataStateInitial implements UserDataState {}

class UserDataStateUpdate implements UserDataState {
  final User user;
  final List<Warehouse> availableWarehouses;
  final bool loading;
  // Может ли редактировать пользователя
  final bool canEditData;

  const UserDataStateUpdate({
    required this.user,
    required this.availableWarehouses,
    required this.canEditData,
    this.loading = false,
  });
}

class UserDataStateCreate implements UserDataState {
  final List<Warehouse> availableWarehouses;
  final bool loading;
  // Может ли редактировать пользователя
  final bool canEditData;

  const UserDataStateCreate({
    required this.availableWarehouses,
    required this.canEditData,
    this.loading = false,
  });
}
