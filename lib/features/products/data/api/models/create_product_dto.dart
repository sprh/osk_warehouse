import 'package:json_annotation/json_annotation.dart';

part 'create_product_dto.g.dart';

@JsonSerializable()
class CreateProductDto {
  final String itemName;
  final List<String> codes;

  const CreateProductDto({
    required this.itemName,
    required this.codes,
  });

  Map<String, dynamic> toJson() => _$CreateProductDtoToJson(this);
}
