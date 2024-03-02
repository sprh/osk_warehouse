// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProductDto _$CreateProductDtoFromJson(Map json) => CreateProductDto(
      itemName: json['item_name'] as String,
      codes: (json['codes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreateProductDtoToJson(CreateProductDto instance) =>
    <String, dynamic>{
      'item_name': instance.itemName,
      'codes': instance.codes,
    };
