import 'package:json_annotation/json_annotation.dart';

import '../../../../user/data/api/models/user_dto.dart';

part 'application_data_dto.g.dart';

@JsonSerializable(createToJson: false)
class ApplicationDataDto {
  final int serialNumber;
  final String description;
  final ApplicationTypeDto type;
  final ApplicationStatusDto status;
  final UserDto createdBy;
  final UserDto? finishedBy;
  final ApplicationSimpleWarehouseDto? sentFromWarehouse;
  final ApplicationSimpleWarehouseDto? sentToWarehouse;
  final String? linkedToApplicationId;

  const ApplicationDataDto({
    required this.serialNumber,
    required this.description,
    required this.type,
    required this.status,
    required this.createdBy,
    this.finishedBy,
    this.sentFromWarehouse,
    this.sentToWarehouse,
    this.linkedToApplicationId,
  });

  factory ApplicationDataDto.fromJson(Map<String, dynamic> json) =>
      _$ApplicationDataDtoFromJson(json);
}

@JsonEnum()
enum ApplicationTypeDto {
  send,
  recieve,
  defect,
  use,
  revert,
}

enum ApplicationStatusDto {
  pending,
  success,
  rejected,
  deleted,
}

@JsonSerializable(createToJson: false)
class ApplicationSimpleWarehouseDto {
  final String warehouseName;
  final String address;

  const ApplicationSimpleWarehouseDto({
    required this.warehouseName,
    required this.address,
  });

  factory ApplicationSimpleWarehouseDto.fromJson(Map<String, dynamic> json) =>
      _$ApplicationSimpleWarehouseDtoFromJson(json);
}
