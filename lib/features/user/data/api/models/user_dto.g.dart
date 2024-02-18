// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map json) => UserDto(
      username: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      warehouses: (json['warehouses'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isAdmin: json['is_admin'] as bool,
      isReviewer: json['is_reviewer'] as bool,
      isSuperuser: json['is_superuser'] as bool,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'warehouses': instance.warehouses,
      'is_admin': instance.isAdmin,
      'is_reviewer': instance.isReviewer,
      'is_superuser': instance.isSuperuser,
    };
