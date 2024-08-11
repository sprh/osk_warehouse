import '../../../common/error/repository_localized_error.dart';
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
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось получить список категорий',
        ),
      );
    }
  }

  @override
  Future<void> saveCategory(String category) async {
    try {
      await _api.createCategory(category);
      await loadCategories();
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось сохранить категорию',
        ),
      );
    }
  }
}
