import 'package:json_annotation/json_annotation.dart';

import 'create_application_data_dto.dart';
import 'create_application_payload_dto.dart';

part 'create_application_dto.g.dart';

@JsonSerializable(createFactory: false)
class CreateApplicationDto {
  final CreateApplicationDataDto applicationData;
  final CreateApplicationPayloadDto applicationPayload;

  const CreateApplicationDto({
    required this.applicationData,
    required this.applicationPayload,
  });

  Map<String, dynamic> toJson() => _$CreateApplicationDtoToJson(this);
}
