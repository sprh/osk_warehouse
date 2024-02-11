// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseDto _$WarehouseDtoFromJson(Map json) => WarehouseDto(
      id: json['id'] as String,
      warehouseName: json['warehouse_name'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$WarehouseDtoToJson(WarehouseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'warehouse_name': instance.warehouseName,
      'address': instance.address,
    };
