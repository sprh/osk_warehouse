import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/dropdown/components/osk_dropdown_menu_item.dart';
import '../../../common/components/dropdown/osk_dropdown_menu.dart';
import '../../../common/components/loading_effect/loading_effect.dart';
import '../../../common/components/tap/osk_tap_animation.dart';
import '../../../common/theme/utils/theme_from_context.dart';
import '../bloc/bloc.dart';
import '../scope/category_scope.dart';

class CategoriesListDropdownItem extends StatelessWidget {
  final String? selectedCategory;
  final bool canAddCategory;
  final void Function(String?) onSelectedCategoryChanged;

  const CategoriesListDropdownItem({
    required this.selectedCategory,
    required this.canAddCategory,
    required this.onSelectedCategoryChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) => CategoryScope(
        child: Builder(
          builder: (context) {
            final container = CategoryScope.containerOf(context);

            return BlocProvider(
              create: (context) => container.bloc,
              child: _CategoriesList(
                canAddCategory: canAddCategory,
                selectedCategory: selectedCategory,
                onSelectedCategoryChanged: onSelectedCategoryChanged,
              ),
            );
          },
        ),
      );
}

class _CategoriesList extends StatelessWidget {
  final bool canAddCategory;
  final String? selectedCategory;
  final void Function(String?) onSelectedCategoryChanged;

  const _CategoriesList({
    required this.canAddCategory,
    required this.selectedCategory,
    required this.onSelectedCategoryChanged,
  });
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CategoriesListBloc, CategoryListState>(
        builder: (context, state) {
          switch (state) {
            case CategoryListLoading():
              return const LoadingEffect(
                child: OskDropDown<String>(
                  items: [],
                  label: 'Загружаем категории..',
                ),
              );
            case CategoryListLoaded():
              if (state.categories.isEmpty) {
                if (canAddCategory) {
                  return OskTapAnimationBuilder(
                    onTap: () => CategoriesListBloc.of(context).add(
                      CategoryListCreateCategory(),
                    ),
                    child: const IgnorePointer(
                      child: OskDropDown<String>(
                        items: [],
                        label: 'Добавьте категорию',
                      ),
                    ),
                  );
                } else {
                  return const OskDropDown<String>(
                    items: [],
                    label: 'Нет категорий',
                  );
                }
              } else {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: OskDropDown<String>(
                        items: state.categories
                            .map(
                              (category) => OskDropdownMenuItem(
                                label: category.categoryName,
                                value: category.categoryName,
                              ),
                            )
                            .toList(),
                        label: 'Выберите категорию',
                        selectedValue: selectedCategory,
                        onSelectedItemChanged: onSelectedCategoryChanged,
                      ),
                    ),
                    if (canAddCategory)
                      InkWell(
                        onTap: () => CategoriesListBloc.of(context).add(
                          CategoryListCreateCategory(),
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: context.textFiledTheme.outlineColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.add,
                              color: context.textFiledTheme.outlineColor,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 16),
                  ],
                );
              }
            case CategoryListError():
              return const OskDropDown<String>(
                items: [],
                label: 'Не удалось загрузить категории',
              );
          }
        },
      );
}
