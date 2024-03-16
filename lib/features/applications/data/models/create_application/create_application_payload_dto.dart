import 'package:json_annotation/json_annotation.dart';

import '../../../../products/data/api/models/product_dto.dart';

part 'create_application_payload_dto.g.dart';

@JsonSerializable(createFactory: false)
class CreateApplicationPayloadDto {
  final List<ProductDto> items;

  const CreateApplicationPayloadDto({required this.items});

  Map<String, dynamic> toJson() => _$CreateApplicationPayloadDtoToJson(this);
}
