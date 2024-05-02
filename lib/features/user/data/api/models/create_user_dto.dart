import 'package:json_annotation/json_annotation.dart';

part 'create_user_dto.g.dart';

@JsonSerializable()
class CreateUserDto {
  final String username; // Неизменяем для пользователей, назначается 1 раз
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final List<String> warehouses; // Список id warehouses
  final bool isAdmin;

  final bool isSuperuser;
  final String password;

  const CreateUserDto({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.warehouses,
    required this.isAdmin,
    required this.isSuperuser,
    required this.password,
  });

  factory CreateUserDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserDtoToJson(this);
}
