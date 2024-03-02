// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListDto _$ProductListDtoFromJson(Map json) => ProductListDto(
      items: (json['items'] as List<dynamic>)
          .map((e) => ProductDto.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
