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

  UserDataStateUpdate copyWith({
    User? user,
    List<Warehouse>? availableWarehouses,
    bool? loading,
    bool? canEditData,
  }) =>
      UserDataStateUpdate(
        user: user ?? this.user,
        availableWarehouses: availableWarehouses ?? this.availableWarehouses,
        loading: loading ?? this.loading,
        canEditData: canEditData ?? this.canEditData,
      );
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

  UserDataStateCreate copyWith({
    List<Warehouse>? availableWarehouses,
    bool? loading,
    bool? canEditData,
  }) =>
      UserDataStateCreate(
        availableWarehouses: availableWarehouses ?? this.availableWarehouses,
        loading: loading ?? this.loading,
        canEditData: canEditData ?? this.canEditData,
      );
}
