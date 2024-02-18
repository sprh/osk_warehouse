// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserDto _$UpdateUserDtoFromJson(Map json) => UpdateUserDto(
      username: json['username'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      warehouses: (json['warehouses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isAdmin: json['is_admin'] as bool?,
      isReviewer: json['is_reviewer'] as bool?,
      isSuperuser: json['is_superuser'] as bool?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UpdateUserDtoToJson(UpdateUserDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'warehouses': instance.warehouses,
      'is_admin': instance.isAdmin,
      'is_reviewer': instance.isReviewer,
      'is_superuser': instance.isSuperuser,
      'password': instance.password,
    };
