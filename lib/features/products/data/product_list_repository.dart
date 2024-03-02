import '../../../common/error/repository_localized_error.dart';
import '../../../common/interface/repository.dart';
import '../../../utils/kotlin_utils.dart';
import '../models/product.dart';
import 'api/api.dart';

// ignore: one_member_abstracts
abstract interface class ProductListRefresher {
  void refreshData();
}

abstract class ProductListRepository extends Repository<List<Product>>
    implements ProductListRefresher {
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
