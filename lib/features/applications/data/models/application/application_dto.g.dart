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
    );
