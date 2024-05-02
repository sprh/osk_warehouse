// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserDto _$CreateUserDtoFromJson(Map json) => CreateUserDto(
      username: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      warehouses: (json['warehouses'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isAdmin: json['is_admin'] as bool,
      isSuperuser: json['is_superuser'] as bool,
      password: json['password'] as String,
    );

Map<String, dynamic> _$CreateUserDtoToJson(CreateUserDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'warehouses': instance.warehouses,
      'is_admin': instance.isAdmin,
      'is_superuser': instance.isSuperuser,
      'password': instance.password,
    };
