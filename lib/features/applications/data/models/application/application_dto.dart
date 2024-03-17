import 'package:json_annotation/json_annotation.dart';

import 'application_data_dto.dart';
import 'application_payload_dto.dart';

part 'application_dto.g.dart';

@JsonSerializable(createToJson: false)
class ApplicationDto {
  final String id;
  final ApplicationDataDto applicationData;
  final ApplicationPayloadDto applicationPayload;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ApplicationActionDto>? actions;

  const ApplicationDto({
    required this.id,
    required this.applicationData,
    required this.applicationPayload,
    required this.createdAt,
    required this.updatedAt,
    this.actions,
  });

  factory ApplicationDto.fromJson(Map<String, dynamic> json) =>
      _$ApplicationDtoFromJson(json);
}

enum ApplicationActionDto {
  reject,
  approve,
  edit,
  delete;
}
