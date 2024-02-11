import 'package:json_annotation/json_annotation.dart';

import 'warehouse_dto.dart';

part 'warehouse_list_dto.g.dart';

@JsonSerializable(createToJson: false)
class WarehouseListDto {
  final List<WarehouseDto> items;

  const WarehouseListDto({
    required this.items,
  });

  factory WarehouseListDto.fromJson(Map<String, dynamic> json) =>
      _$WarehouseListDtoFromJson(json);
}
