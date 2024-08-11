// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationDataDto _$ApplicationDataDtoFromJson(Map json) => ApplicationDataDto(
      serialNumber: (json['serial_number'] as num).toInt(),
      description: json['description'] as String,
      type: $enumDecode(_$ApplicationTypeDtoEnumMap, json['type']),
      status: $enumDecode(_$ApplicationStatusDtoEnumMap, json['status']),
      createdBy: UserDto.fromJson(
          Map<String, dynamic>.from(json['created_by'] as Map)),
      finishedBy: json['finished_by'] == null
          ? null
          : UserDto.fromJson(
              Map<String, dynamic>.from(json['finished_by'] as Map)),
      sentFromWarehouse: json['sent_from_warehouse'] == null
          ? null
          : ApplicationSimpleWarehouseDto.fromJson(
              Map<String, dynamic>.from(json['sent_from_warehouse'] as Map)),
      sentToWarehouse: json['sent_to_warehouse'] == null
          ? null
          : ApplicationSimpleWarehouseDto.fromJson(
              Map<String, dynamic>.from(json['sent_to_warehouse'] as Map)),
      linkedToApplicationId: json['linked_to_application_id'] as String?,
    );

const _$ApplicationTypeDtoEnumMap = {
  ApplicationTypeDto.send: 'send',
  ApplicationTypeDto.recieve: 'recieve',
  ApplicationTypeDto.defect: 'defect',
  ApplicationTypeDto.use: 'use',
  ApplicationTypeDto.revert: 'revert',
};

const _$ApplicationStatusDtoEnumMap = {
  ApplicationStatusDto.pending: 'pending',
  ApplicationStatusDto.success: 'success',
  ApplicationStatusDto.rejected: 'rejected',
  ApplicationStatusDto.deleted: 'deleted',
};

ApplicationSimpleWarehouseDto _$ApplicationSimpleWarehouseDtoFromJson(
        Map json) =>
    ApplicationSimpleWarehouseDto(
      warehouseName: json['warehouse_name'] as String,
      address: json['address'] as String,
    );
