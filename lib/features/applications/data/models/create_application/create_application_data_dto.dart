import 'package:json_annotation/json_annotation.dart';

part 'create_application_data_dto.g.dart';

@JsonSerializable(createFactory: false)
class CreateApplicationDataDto {
  final String description;
  final String type;
  final String? sentFromWarehouseId;
  final String? sentToWarehouseId;
  final String? linkedToApplicationId;

  const CreateApplicationDataDto({
    required this.description,
    required this.type,
    required this.sentToWarehouseId,
    this.sentFromWarehouseId,
    this.linkedToApplicationId,
  });

  Map<String, dynamic> toJson() => _$CreateApplicationDataDtoToJson(this);
}
