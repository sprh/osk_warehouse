import 'package:json_annotation/json_annotation.dart';

part 'warehouse_create_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class WarehouseCreateRequestDto {
  final String warehouseName;
  final String address;

  const WarehouseCreateRequestDto({
    required this.warehouseName,
    required this.address,
  });

  Map<String, dynamic> toJson() => _$WarehouseCreateRequestDtoToJson(this);
}
