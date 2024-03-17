// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationDto _$ApplicationDtoFromJson(Map json) => ApplicationDto(
      id: json['id'] as String,
      applicationData: ApplicationDataDto.fromJson(
          Map<String, dynamic>.from(json['application_data'] as Map)),
      applicationPayload: ApplicationPayloadDto.fromJson(
          Map<String, dynamic>.from(json['application_payload'] as Map)),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ApplicationActionDtoEnumMap, e))
          .toList(),
    );

const _$ApplicationActionDtoEnumMap = {
  ApplicationActionDto.reject: 'reject',
  ApplicationActionDto.approve: 'approve',
  ApplicationActionDto.edit: 'edit',
  ApplicationActionDto.delete: 'delete',
};
