import 'package:json_annotation/json_annotation.dart';

import '../application/application_dto.dart';

part 'applications_list_response.g.dart';

@JsonSerializable(createToJson: false)
class ApplicationsListResponse {
  final List<ApplicationDto> items;
  final String? cursor;

  ApplicationsListResponse({
    required this.items,
    this.cursor,
  });

  factory ApplicationsListResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplicationsListResponseFromJson(json);
}
