import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import 'models/warehouse_create_request_dto.dart';
import 'models/warehouse_dto.dart';
import 'models/warehouse_list_dto.dart';

abstract class WarehouseApi {
  factory WarehouseApi(DioClient dio) => _WarehouseApi(dio);

  Future<WarehouseListDto> getWarehouseList();

  Future<void> deleteWarehouse(String id);

  Future<WarehouseDto> updateWarehouse(WarehouseDto dto);

  Future<WarehouseDto> getWarehouse(String id);

  Future<WarehouseDto> createWarehouse(
    WarehouseCreateRequestDto dto,
    String idempotencyToken,
  );
}

class _WarehouseApi implements WarehouseApi {
  final DioClient _dio;

  const _WarehouseApi(this._dio);

  @override
  Future<WarehouseDto> createWarehouse(
    WarehouseCreateRequestDto dto,
    String idempotencyToken,
  ) async {
    final response = await _dio.core.post<Map<String, dynamic>>(
      _ApiConstants.warehousePath,
      data: dto.toJson(),
      options: Options(
        headers: {
          _ApiConstants.requestIdempotencyToken: idempotencyToken,
        },
      ),
    );

    return WarehouseDto.fromJson(response.data!);
  }

  @override
  Future<void> deleteWarehouse(String id) =>
      _dio.core.delete<Map<String, dynamic>>(
        _ApiConstants.warehousePath,
        queryParameters: {_ApiConstants.warehouseIdQuery: id},
      );

  @override
  Future<WarehouseDto> getWarehouse(String id) async {
    final response = await _dio.core.get<Map<String, dynamic>>(
      _ApiConstants.warehousePath,
      queryParameters: {_ApiConstants.warehouseIdQuery: id},
    );

    return WarehouseDto.fromJson(response.data!);
  }

  @override
  Future<WarehouseListDto> getWarehouseList() async {
    final response = await _dio.core.get<Map<String, dynamic>>(
      _ApiConstants.warehouseListPath,
    );

    return WarehouseListDto.fromJson(response.data!);
  }

  @override
  Future<WarehouseDto> updateWarehouse(WarehouseDto dto) async {
    final response = await _dio.core.put<Map<String, dynamic>>(
      _ApiConstants.warehousePath,
      data: dto.toJson(),
    );

    return WarehouseDto.fromJson(response.data!);
  }
}

class _ApiConstants {
  static const warehouseListPath = '/warehouse/list';
  static const warehousePath = '/warehouse';

  // query
  static const warehouseIdQuery = 'warehouse_id';

  // header
  static const requestIdempotencyToken = 'x-request-idempotency-token';
}
