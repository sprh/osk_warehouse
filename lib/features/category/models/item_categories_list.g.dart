// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_categories_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCategoriesList _$ItemCategoriesListFromJson(Map json) => ItemCategoriesList(
      (json['categories'] as List<dynamic>)
          .map(
              (e) => ItemCategory.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
