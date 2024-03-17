import 'package:json_annotation/json_annotation.dart';

import '../../../../products/data/api/models/product_dto.dart';

part 'application_payload_dto.g.dart';

@JsonSerializable(createToJson: false)
class ApplicationPayloadDto {
  final List<ProductDto> items;

  const ApplicationPayloadDto({
    required this.items,
  });

  factory ApplicationPayloadDto.fromJson(Map<String, dynamic> json) =>
      _$ApplicationPayloadDtoFromJson(json);
}
