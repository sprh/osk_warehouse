// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDto _$ProductDtoFromJson(Map json) => ProductDto(
      id: json['id'] as String,
      itemName: json['item_name'] as String,
      codes: (json['codes'] as List<dynamic>).map((e) => e as String).toList(),
      warehouseCount: (json['warehouse_count'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e),
      ),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$ProductDtoToJson(ProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_name': instance.itemName,
      'codes': instance.codes,
      'warehouse_count': instance.warehouseCount,
      'count': instance.count,
    };
