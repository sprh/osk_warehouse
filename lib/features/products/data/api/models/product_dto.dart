import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  final String id;
  final String itemName;
  final List<String> codes;
  final Map<String, dynamic>? warehouseCount;
  final int? count;

  const ProductDto({
    required this.id,
    required this.itemName,
    required this.codes,
    this.warehouseCount,
    this.count,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}
