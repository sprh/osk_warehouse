import 'package:json_annotation/json_annotation.dart';

import 'user_dto.dart';

part 'user_list_dto.g.dart';

@JsonSerializable(createToJson: false)
class UserListDto {
  final List<UserDto> items;

  const UserListDto({required this.items});

  factory UserListDto.fromJson(Map<String, dynamic> json) =>
      _$UserListDtoFromJson(json);
}
