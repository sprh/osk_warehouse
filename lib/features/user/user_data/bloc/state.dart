import '../../../warehouse/models/warehouse.dart';
import '../../models/user.dart';

sealed class UserDataState {}

class UserDataStateInitial implements UserDataState {}

class UserDataStateUpdate implements UserDataState {
  final User user;
  final List<Warehouse> availableWarehouses;
  final bool loading;

  const UserDataStateUpdate({
    required this.user,
    required this.availableWarehouses,
    this.loading = false,
  });
}

class UserDataStateCreate implements UserDataState {
  final List<Warehouse> availableWarehouses;
  final bool loading;

  const UserDataStateCreate({
    required this.availableWarehouses,
    this.loading = false,
  });
}
