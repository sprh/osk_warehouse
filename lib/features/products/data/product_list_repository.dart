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

  Future<void> refreshProductList({
    required String? warehouseId,
    String? searchCategory,
    String? searchText,
  });

  Future<void> deleteProduct(String id, {required String? warehouseId});
}

class _ProductListRepository extends Repository<List<Product>>
    implements ProductListRepository, ProductListRefresher {
  final ProductApi _api;

  String? warehouseId;
  String? searchCategory;
  String? searchText;

  _ProductListRepository(
    this._api,
  );

  @override
  Future<List<Product>> productList({required String? warehouseId}) async {
    final data = await warehouseId?.let(
          (id) => _api.getProductListByWarehouse(
            warehouseId,
            null,
            null,
          ),
        ) ??
        await _api.getProductList();

    final products = data.items.map(Product.fromDto);
    return products.toList();
  }

  @override
  Future<void> refreshProductList({
    required String? warehouseId,
    String? searchCategory,
    String? searchText,
  }) async {
    if (loading) {
      return;
    }

    this.warehouseId = warehouseId;

    await _refreshData(
      warehouseId,
      searchCategory,
      searchText,
    );
  }

  @override
  void refreshData() => _refreshData(warehouseId, searchCategory, searchText);

  @override
  Future<void> deleteProduct(
    String id, {
    required String? warehouseId,
  }) async {
    setLoading();

    try {
      await _api.deleteProduct(id);
      await _refreshData(warehouseId, searchCategory, searchText);
    } on Exception catch (e) {
      onError(
        fallbackMessage: 'Не удалось удалить продукт',
        e: e,
      );
    }
  }

  Future<void> _refreshData(
    String? warehouseId,
    String? searchCategory,
    String? searchText,
  ) async {
    this.searchCategory = searchCategory;
    this.searchText = searchText;

    setLoading();

    try {
      final data = await warehouseId?.let(
            (id) => _api.getProductListByWarehouse(
              warehouseId,
              searchCategory,
              searchText,
            ),
          ) ??
          await _api.getProductList();

      final products = data.items.map(Product.fromDto);
      emit(products.toList());
    } on Exception catch (e) {
      onError(
        fallbackMessage: 'Не удалось получить список продуктов',
        e: e,
      );
    }
  }
}
