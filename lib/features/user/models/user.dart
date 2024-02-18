import '../data/api/models/user_dto.dart';
import 'user_access_types.dart';

class User {
  final String username; // Неизменяем для пользователей, назначается 1 раз
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final List<String> warehouses; // Список id warehouses
  final bool isAdmin;
  final bool isReviewer;
  final bool isSuperuser;
  final bool isCurrentUser;

  const User({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.warehouses,
    required this.isAdmin,
    required this.isReviewer,
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
        isReviewer: dto.isReviewer,
        isSuperuser: dto.isSuperuser,
        isCurrentUser: isCurrentUser,
      );

  String get fullName => '$firstName $lastName';

  Set<UserAccessTypes> get accesses => {
        if (isAdmin) UserAccessTypes.admin,
        if (isReviewer) UserAccessTypes.reviewer,
        if (isSuperuser) UserAccessTypes.superuser,
      };
}