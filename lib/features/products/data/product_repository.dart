import 'package:uuid/uuid.dart';

import '../../../common/error/repository_localized_error.dart';
import '../../../common/interface/repository.dart';
import '../../warehouse/data/repository.dart';
import '../../warehouse/models/warehouse.dart';
import '../models/product.dart';
import 'api/api.dart';
import 'api/models/create_product_dto.dart';
import 'api/models/product_dto.dart';
import 'api/models/update_product_dto.dart';
import 'product_list_repository.dart';

abstract class ProductRepository
    extends Repository<(Product?, List<Warehouse>)> {
  factory ProductRepository(
    ProductApi api,
    WarehouseListGetter warehouseListGetter,
    ProductListRefresher productListRefresher,
  ) =>
      _ProductRepository(
        api,
        warehouseListGetter,
        productListRefresher,
      );

  Future<void> refreshData(String? productId);

  Future<void> createProduct({
    required String name,
    required List<String> codes,
  });

  Future<void> updateProduct({
    required String id,
    required String name,
    required List<String> codes,
  });
}

class _ProductRepository extends Repository<(Product?, List<Warehouse>)>
    implements ProductRepository {
  final ProductApi _api;
  final WarehouseListGetter _warehouseListGetter;
  final ProductListRefresher _productListRefresher;

  _ProductRepository(
    this._api,
    this._warehouseListGetter,
    this._productListRefresher,
  );

  @override
  Future<void> createProduct({
    required String name,
    required List<String> codes,
  }) async {
    try {
      await _api.createProduct(
        CreateProductDto(
          itemName: name,
          codes: codes,
        ),
        const Uuid().v4(),
      );
      _productListRefresher.refreshData();
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось создать пользователя',
        ),
      );
      rethrow;
    }
  }

  @override
  Future<void> refreshData(String? productId) async {
    try {
      if (productId == null) {
        final warehouses = await _warehouseListGetter.warehouseList;
        emit((null, warehouses));
      } else {
        final data = await Future.wait(
          [_api.getProduct(productId), _warehouseListGetter.warehouseList],
        );
        final productDto = data[0] as ProductDto;
        final product = Product.fromDto(
          productDto,
        );
        final warehouses = data[1] as List<Warehouse>;
        emit((product, warehouses));
      }
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось получить данные пользователя',
        ),
      );
    }
  }

  @override
  Future<void> updateProduct({
    required String id,
    required String name,
    required List<String> codes,
  }) async {
    try {
      await _api.updateProduct(
        UpdateProductDto(
          id: id,
          itemName: name,
          codes: codes,
        ),
      );
      _productListRefresher.refreshData();
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось создать пользователя',
        ),
      );
      rethrow;
    }
  }
}
