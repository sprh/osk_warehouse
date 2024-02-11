// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseListDto _$WarehouseListDtoFromJson(Map json) => WarehouseListDto(
      items: (json['items'] as List<dynamic>)
          .map(
              (e) => WarehouseDto.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
