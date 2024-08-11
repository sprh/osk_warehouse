import 'package:json_annotation/json_annotation.dart';

part 'item_category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemCategory {
  final String categoryName;

  const ItemCategory(this.categoryName);

  factory ItemCategory.fromJson(Map<String, dynamic> json) =>
      _$ItemCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCategoryToJson(this);
}
