import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/error/repository_localized_error.dart';
import '../../../common/interface/repository.dart';
import '../../../common/interface/repository_subscriber.dart';
import '../../../core/navigation/manager/navigation_manager.dart';
import '../data/repository.dart';
import '../models/item_category.dart';
import '../presentation/add_category_modal_bottom_sheet.dart';

part 'state.dart';
part 'event.dart';

abstract class CategoriesListBloc
    extends Bloc<CategoryListEvent, CategoryListState> {
  factory CategoriesListBloc(
    CategoriesRepository repository,
    NavigationManager navigationManager,
  ) = _CategoriesListBloc;

  static CategoriesListBloc of(BuildContext context) =>
      BlocProvider.of(context);
}

class _CategoriesListBloc extends Bloc<CategoryListEvent, CategoryListState>
    with RepositorySubscriber<List<ItemCategory>>
    implements CategoriesListBloc {
  final CategoriesRepository _repository;
  final NavigationManager _navigationManager;

  _CategoriesListBloc(
    this._repository,
    this._navigationManager,
  ) : super(CategoryListLoading()) {
    on<CategoryListEvent>(_onEvent);
  }

  @override
  Repository<List<ItemCategory>> get repository => _repository;

  @override
  void onData(List<ItemCategory> value) => add(
        _CategoryListEventSetData(value),
      );

  @override
  void onLoading(bool loading) {
    if (loading) {
      add(_CategoryListEventSetLoading());
    }
  }

  @override
  void onRepositoryError(RepositoryLocalizedError error) =>
      add(_CategoryListEventSetError());

  Future<void> _onEvent(
    CategoryListEvent event,
    Emitter<CategoryListState> emit,
  ) async {
    switch (event) {
      case CategoryListEventInitialize():
        _repository.start();
        start();
      case _CategoryListEventSetData():
        emit(CategoryListLoaded(event.categories));
      case _CategoryListEventSetLoading():
        emit(CategoryListLoading());
      case _CategoryListEventSetError():
        emit(CategoryListError());
      case CategoryListCreateCategory():
        _onAddCategory();
      case CategoryListSaveCategory():
        await _onSaveCategory(event.categoryName, emit);
    }
  }

  void _onAddCategory() => _navigationManager.showModal(
        (_) => AddCategoryModalBottomSheet(
          onSaveTap: (value) {
            add(CategoryListSaveCategory(value));
            _navigationManager.popDialog();
          },
        ),
      );

  Future<void> _onSaveCategory(
    String value,
    Emitter<CategoryListState> emit,
  ) async {
    emit(CategoryListLoading());
    await _repository.saveCategory(value);
  }
}
