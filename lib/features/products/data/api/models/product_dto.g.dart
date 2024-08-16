// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDto _$ProductDtoFromJson(Map json) => ProductDto(
      id: json['id'] as String,
      itemName: json['item_name'] as String,
      codes: (json['codes'] as List<dynamic>).map((e) => e as String).toList(),
      itemType: json['item_type'] as String?,
      manufacturer: json['manufacturer'] as String,
      model: json['model'] as String,
      description: json['description'] as String?,
      warehouseCount: (json['warehouse_count'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e as int),
      ),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$ProductDtoToJson(ProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_name': instance.itemName,
      'item_type': instance.itemType,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'description': instance.description,
      'codes': instance.codes,
      'count': instance.count,
    };
