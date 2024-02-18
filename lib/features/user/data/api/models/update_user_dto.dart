import 'package:json_annotation/json_annotation.dart';

part 'update_user_dto.g.dart';

@JsonSerializable()
class UpdateUserDto {
  final String username; // Неизменяем для пользователей, назначается 1 раз
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final List<String>? warehouses; // Список id warehouses
  final bool? isAdmin;
  final bool? isReviewer;
  final bool? isSuperuser;
  final String? password;

  const UpdateUserDto({
    required this.username,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.warehouses,
    this.isAdmin,
    this.isReviewer,
    this.isSuperuser,
    this.password,
  });

  factory UpdateUserDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDtoToJson(this);
}
