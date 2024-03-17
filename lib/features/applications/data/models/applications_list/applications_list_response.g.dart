// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applications_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationsListResponse _$ApplicationsListResponseFromJson(Map json) =>
    ApplicationsListResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              ApplicationDto.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      cursor: json['cursor'] as String?,
    );
