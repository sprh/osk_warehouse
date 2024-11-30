import 'package:flutter/material.dart';

import '../../../core/scopes/account_scope.dart';
import '../bloc/bloc.dart';
import '../data/api.dart';
import '../data/repository.dart';

class CategoryContainer {
  final CategoriesListBloc _bloc;
  final CategoriesRepository _repository;

  CategoriesListBloc get bloc => _bloc;
  CategoriesRepository get repository => _repository;

  const CategoryContainer(
    this._bloc,
    this._repository,
  );

  factory CategoryContainer.create(
    BuildContext context,
  ) {
    final accountScope = AccountScope.of(context);
    final api = CategoryApiImpl(accountScope.dio);
    final repository = CategoriesRepository(api);
    final bloc = CategoriesListBloc(
      repository,
      accountScope.navigationManager,
    );

    return CategoryContainer(bloc, repository);
  }

  void init() => _bloc.add(CategoryListEventInitialize());

  void dispose() => _bloc.close();
}
