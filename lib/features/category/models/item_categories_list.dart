import 'package:json_annotation/json_annotation.dart';

import 'item_category.dart';

part 'item_categories_list.g.dart';

@JsonSerializable(createToJson: false)
class ItemCategoriesList {
  final List<ItemCategory> categories;

  const ItemCategoriesList(this.categories);

  factory ItemCategoriesList.fromJson(Map<String, dynamic> json) =>
      _$ItemCategoriesListFromJson(json);
}
