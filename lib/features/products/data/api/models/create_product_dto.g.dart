// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProductDto _$CreateProductDtoFromJson(Map json) => CreateProductDto(
      itemName: json['item_name'] as String,
      itemType: json['item_type'] as String,
      codes: (json['codes'] as List<dynamic>).map((e) => e as String).toList(),
      manufacturer: json['manufacturer'] as String,
      model: json['model'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CreateProductDtoToJson(CreateProductDto instance) =>
    <String, dynamic>{
      'item_name': instance.itemName,
      'item_type': instance.itemType,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'description': instance.description,
      'codes': instance.codes,
    };
