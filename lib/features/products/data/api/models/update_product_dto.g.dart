// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProductDto _$UpdateProductDtoFromJson(Map json) => UpdateProductDto(
      id: json['id'] as String,
      itemName: json['item_name'] as String,
      itemType: json['item_type'] as String?,
      manufacturer: json['manufacturer'] as String,
      model: json['model'] as String,
      description: json['description'] as String?,
      codes: (json['codes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UpdateProductDtoToJson(UpdateProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_name': instance.itemName,
      'item_type': instance.itemType,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'description': instance.description,
      'codes': instance.codes,
    };
