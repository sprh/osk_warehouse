import 'package:json_annotation/json_annotation.dart';

part 'application_dto.g.dart';

@JsonSerializable()
class ApplicationDto {
  final String id;

  const ApplicationDto({
    required this.id,
  });

  factory ApplicationDto.fromJson(Map<String, dynamic> json) =>
      _$ApplicationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationDtoToJson(this);
}
