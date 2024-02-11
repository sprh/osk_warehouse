import 'package:json_annotation/json_annotation.dart';

part 'warehouse_dto.g.dart';

@JsonSerializable()
class WarehouseDto {
  final String id;
  final String warehouseName;
  final String address;

  const WarehouseDto({
    required this.id,
    required this.warehouseName,
    required this.address,
  });

  Map<String, dynamic> toJson() => _$WarehouseDtoToJson(this);

  factory WarehouseDto.fromJson(Map<String, dynamic> json) =>
      _$WarehouseDtoFromJson(json);
}
