import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String username; // Неизменяем для пользователей, назначается 1 раз
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final List<String> warehouses; // Список id warehouses
  final bool isAdmin;
  final bool isReviewer;
  final bool isSuperuser;

  const UserDto({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.warehouses,
    required this.isAdmin,
    required this.isReviewer,
    required this.isSuperuser,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
