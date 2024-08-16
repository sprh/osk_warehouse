import '../../../common/interface/repository.dart';
import '../models/item_category.dart';
import 'api.dart';

abstract class CategoriesRepository extends Repository<List<ItemCategory>> {
  factory CategoriesRepository(CategoryApi api) = _CategoriesRepositoryImpl;

  Future<void> loadCategories();

  Future<void> saveCategory(String category);
}

class _CategoriesRepositoryImpl extends Repository<List<ItemCategory>>
    implements CategoriesRepository {
  final CategoryApi _api;

  _CategoriesRepositoryImpl(this._api);

  @override
  void start() {
    super.start();
    loadCategories();
  }

  @override
  Future<void> loadCategories() async {
    setLoading();

    try {
      final categories = await _api.getCategories();
      emit(categories);
    } on Exception catch (e) {
      onError(
        fallbackMessage: 'Не удалось получить список категорий',
        e: e,
      );
    }
  }

  @override
  Future<void> saveCategory(String category) async {
    try {
      await _api.createCategory(category);
      await loadCategories();
    } on Exception catch (e) {
      onError(
        fallbackMessage: 'Не удалось сохранить категорию',
        e: e,
      );
    }
  }
}
