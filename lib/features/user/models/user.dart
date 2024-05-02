import '../data/api/models/user_dto.dart';
import 'user_access_types.dart';

class User {
  final String username; // Неизменяем для пользователей, назначается 1 раз
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final List<String> warehouses; // Список id warehouses

  /// Может получать выгрузки, видеть склады и остатки, менять карточки товаров,
  /// одобрять заявки, видеть перемещения(заявки)
  final bool isAdmin;

  /// Может все
  final bool isSuperuser;

  final bool isCurrentUser;

  const User({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.warehouses,
    required this.isAdmin,
    required this.isSuperuser,
    required this.isCurrentUser,
  });

  factory User.fromDto(UserDto dto, bool isCurrentUser) => User(
        username: dto.username,
        firstName: dto.firstName,
        lastName: dto.lastName,
        phoneNumber: dto.phoneNumber,
        warehouses: dto.warehouses,
        isAdmin: dto.isAdmin,
        isSuperuser: dto.isSuperuser,
        isCurrentUser: isCurrentUser,
      );

  String get fullName => '$firstName $lastName';

  UserAccessTypes? get accessType {
    if (isAdmin) {
      return UserAccessTypes.admin;
    }

    if (isSuperuser) {
      return UserAccessTypes.superuser;
    }

    return null;
  }

  bool get canManageUser => isSuperuser;

  bool get canManageWarehouse => isSuperuser;

  bool get canManagerProducts => isSuperuser || isAdmin;
}
