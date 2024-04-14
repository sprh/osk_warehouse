import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import 'models/create_product_dto.dart';
import 'models/product_dto.dart';
import 'models/product_list_dto.dart';
import 'models/update_product_dto.dart';

abstract class ProductApi {
  factory ProductApi(DioClient dio) => _ProductApi(dio);

  Future<ProductListDto> getProductList();

  Future<ProductListDto> getProductListByWarehouse(String warehouseId);

  Future<void> deleteProduct(String id);

  Future<ProductDto> updateProduct(UpdateProductDto dto);

  Future<ProductDto> getProduct(String id);

  Future<ProductDto> createProduct(
    CreateProductDto dto,
    String idempotencyToken,
  );
}

class _ProductApi implements ProductApi {
  final DioClient _dio;

  const _ProductApi(this._dio);

  @override
  Future<ProductDto> createProduct(
    CreateProductDto dto,
    String idempotencyToken,
  ) async {
    final response = await _dio.core.post<Map<String, dynamic>>(
      _ApiConstants.productsPath,
      data: dto.toJson(),
      options: Options(
        headers: {
          _ApiConstants.requestIdempotencyToken: idempotencyToken,
        },
      ),
    );

    return ProductDto.fromJson(response.data!);
  }

  @override
  Future<void> deleteProduct(String id) =>
      _dio.core.delete<Map<String, dynamic>>(
        _ApiConstants.productsPath,
        queryParameters: {_ApiConstants.itemId: id},
      );

  @override
  Future<ProductDto> getProduct(String id) async {
    final response = await _dio.core.get<Map<String, dynamic>>(
      _ApiConstants.productsPath,
      queryParameters: {_ApiConstants.itemId: id},
    );

    return ProductDto.fromJson(response.data!);
  }

  @override
  Future<ProductListDto> getProductList() async {
    final response = await _dio.core.get<Map<String, dynamic>>(
      _ApiConstants.productListPath,
    );

    return ProductListDto.fromJson(response.data!);
  }

  @override
  Future<ProductDto> updateProduct(UpdateProductDto dto) async {
    final response = await _dio.core.put<Map<String, dynamic>>(
      _ApiConstants.productsPath,
      data: dto.toJson(),
    );

    return ProductDto.fromJson(response.data!);
  }

  @override
  Future<ProductListDto> getProductListByWarehouse(String warehouseId) async {
    final response = await _dio.core.get<Map<String, dynamic>>(
      _ApiConstants.productsByWarehouse,
      queryParameters: {_ApiConstants.warehouseId: warehouseId},
    );

    return ProductListDto.fromJson(response.data!);
  }
}

class _ApiConstants {
  static const productListPath = '/items/list';
  static const productsPath = '/items';
  static const productsByWarehouse = '/items/by-warehouse';

  // query
  static const itemId = 'item_id';
  static const warehouseId = 'warehouse_id';

  // header
  static const requestIdempotencyToken = 'x-request-idempotency-token';
}
