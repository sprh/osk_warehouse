import '../../../core/network/dio_client.dart';
import '../models/item_categories_list.dart';
import '../models/item_category.dart';

part 'api_path.dart';

abstract class CategoryApi {
  Future<void> createCategory(String name);

  Future<List<ItemCategory>> getCategories();
}

class CategoryApiImpl implements CategoryApi {
  final DioClient _dio;

  const CategoryApiImpl(this._dio);

  @override
  Future<void> createCategory(String name) => _dio.core.post<Object?>(
        _CategoryApiPath.create,
        data: ItemCategory(name).toJson(),
      );

  @override
  Future<List<ItemCategory>> getCategories() async {
    final response = await _dio.core.get<Map<String, dynamic>>(
      _CategoryApiPath.list,
    );
    return ItemCategoriesList.fromJson(response.data!).categories;
  }
}
