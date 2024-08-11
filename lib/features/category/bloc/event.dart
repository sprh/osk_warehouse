part of 'bloc.dart';

sealed class CategoryListEvent {}

class CategoryListEventInitialize extends CategoryListEvent {}

class _CategoryListEventSetData extends CategoryListEvent {
  final List<ItemCategory> categories;

  _CategoryListEventSetData(this.categories);
}

class _CategoryListEventSetLoading extends CategoryListEvent {}

class _CategoryListEventSetError extends CategoryListEvent {}

class CategoryListCreateCategory extends CategoryListEvent {}

class CategoryListSaveCategory extends CategoryListEvent {
  final String categoryName;

  CategoryListSaveCategory(this.categoryName);
}
