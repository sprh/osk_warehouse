part of 'bloc.dart';

sealed class CategoryListState {
  const CategoryListState();
}

class CategoryListLoading extends CategoryListState {}

class CategoryListLoaded extends CategoryListState {
  final List<ItemCategory> categories;

  const CategoryListLoaded(
    this.categories,
  );
}

class CategoryListError extends CategoryListState {}
