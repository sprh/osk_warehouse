// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_payload_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationPayloadDto _$ApplicationPayloadDtoFromJson(Map json) =>
    ApplicationPayloadDto(
      items: (json['items'] as List<dynamic>)
          .map((e) => ProductDto.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
