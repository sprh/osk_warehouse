import 'package:json_annotation/json_annotation.dart';

import 'product_dto.dart';

part 'product_list_dto.g.dart';

@JsonSerializable(createToJson: false)
class ProductListDto {
  final List<ProductDto> items;

  const ProductListDto({
    required this.items,
  });

  factory ProductListDto.fromJson(Map<String, dynamic> json) =>
      _$ProductListDtoFromJson(json);
}
