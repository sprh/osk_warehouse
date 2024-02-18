// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListDto _$UserListDtoFromJson(Map json) => UserListDto(
      items: (json['items'] as List<dynamic>)
          .map((e) => UserDto.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
