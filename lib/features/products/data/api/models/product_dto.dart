import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  final String id;
  final String itemName;
  final String itemType;
  final String manufacturer;
  final String model;
  final String? description;
  final List<String> codes;
  final Map<String, int>? warehouseCount;
  final int? count;

  const ProductDto({
    required this.id,
    required this.itemName,
    required this.codes,
    required this.itemType,
    required this.manufacturer,
    required this.model,
    this.description,
    this.warehouseCount,
    this.count,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}
