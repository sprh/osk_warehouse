import 'package:json_annotation/json_annotation.dart';

part 'update_product_dto.g.dart';

@JsonSerializable()
class UpdateProductDto {
  final String id;
  final String itemName;
  final List<String> codes;

  const UpdateProductDto({
    required this.id,
    required this.itemName,
    required this.codes,
  });

  Map<String, dynamic> toJson() => _$UpdateProductDtoToJson(this);
}
