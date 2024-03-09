import 'package:json_annotation/json_annotation.dart';

part 'create_product_dto.g.dart';

@JsonSerializable()
class CreateProductDto {
  final String itemName;
  final String itemType;
  final String manufacturer;
  final String model;
  final String? description;
  final List<String> codes;

  const CreateProductDto({
    required this.itemName,
    required this.itemType,
    required this.codes,
    required this.manufacturer,
    required this.model,
    required this.description,
  });

  Map<String, dynamic> toJson() => _$CreateProductDtoToJson(this);
}
