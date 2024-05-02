import '../../../common/error/repository_localized_error.dart';
import '../../../common/interface/repository.dart';
import '../../../common/utils/kotlin_utils.dart';
import '../models/product.dart';
import 'api/api.dart';

// ignore: one_member_abstracts
abstract interface class ProductListRefresher {
  void refreshData();
}

// ignore: one_member_abstracts
abstract interface class ProductListGetter {
  Future<List<Product>> productList({required String? warehouseId});
}

abstract class ProductListRepository extends Repository<List<Product>>
    implements ProductListRefresher, ProductListGetter {
  factory ProductListRepository(
    ProductApi api,
  ) =>
      _ProductListRepository(api);

  Future<void> refreshProductList({required String? warehouseId});

  Future<void> deleteProduct(String id, {required String? warehouseId});
}

class _ProductListRepository extends Repository<List<Product>>
    implements ProductListRepository, ProductListRefresher {
  final ProductApi _api;

  String? warehouseId;

  _ProductListRepository(
    this._api,
  );

  @override
  Future<List<Product>> productList({required String? warehouseId}) async {
    final data = await warehouseId?.let(
          (id) => _api.getProductListByWarehouse(warehouseId),
        ) ??
        await _api.getProductList();

    final products = data.items.map(Product.fromDto);
    return products.toList();
  }

  @override
  Future<void> refreshProductList({required String? warehouseId}) async {
    if (loading) {
      return;
    }

    this.warehouseId = warehouseId;

    await _refreshData(warehouseId);
  }

  @override
  void refreshData() => _refreshData(warehouseId);

  @override
  Future<void> deleteProduct(
    String id, {
    required String? warehouseId,
  }) async {
    setLoading();

    try {
      await _api.deleteProduct(id);
      await _refreshData(warehouseId);
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось получить список пользователей',
        ),
      );
    }
  }

  Future<void> _refreshData(String? warehouseId) async {
    setLoading();

    try {
      final data = await warehouseId?.let(
            (id) => _api.getProductListByWarehouse(warehouseId),
          ) ??
          await _api.getProductList();

      final products = data.items.map(Product.fromDto);
      emit(products.toList());
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось получить список пользователей',
        ),
      );
    }
  }
}
