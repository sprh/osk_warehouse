import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import 'models/create_user_dto.dart';
import 'models/update_user_dto.dart';
import 'models/user_dto.dart';
import 'models/user_list_dto.dart';

abstract class UserApi {
  factory UserApi(DioClient dio) => _UserApi(dio);

  Future<UserListDto> getUserList();

  Future<void> deleteUser(String id);

  Future<UserDto> updateUser(UpdateUserDto dto);

  Future<UserDto> getUser(String id);

  Future<UserDto> createUser(
    CreateUserDto dto,
    String idempotencyToken,
  );
}

class _UserApi implements UserApi {
  final DioClient _dio;

  const _UserApi(this._dio);

  @override
  Future<UserDto> createUser(
    CreateUserDto dto,
    String idempotencyToken,
  ) async {
    final response = await _dio.core.post<Map<String, dynamic>>(
      _ApiConstants.usersPath,
      data: dto.toJson(),
      options: Options(
        headers: {
          _ApiConstants.requestIdempotencyToken: idempotencyToken,
        },
      ),
    );

    return UserDto.fromJson(response.data!);
  }

  @override
  Future<void> deleteUser(String id) => _dio.core.delete<Map<String, dynamic>>(
        _ApiConstants.usersPath,
        queryParameters: {_ApiConstants.usernameQuery: id},
      );

  @override
  Future<UserDto> getUser(String id) async {
    final response = await _dio.core.get<Map<String, dynamic>>(
      _ApiConstants.usersPath,
      queryParameters: {_ApiConstants.usernameQuery: id},
    );

    return UserDto.fromJson(response.data!);
  }

  @override
  Future<UserListDto> getUserList() async {
    final response = await _dio.core.get<Map<String, dynamic>>(
      _ApiConstants.usersListPath,
    );

    return UserListDto.fromJson(response.data!);
  }

  @override
  Future<UserDto> updateUser(UpdateUserDto dto) async {
    final response = await _dio.core.put<Map<String, dynamic>>(
      _ApiConstants.usersPath,
      data: dto.toJson(),
    );

    return UserDto.fromJson(response.data!);
  }
}

class _ApiConstants {
  static const usersListPath = '/users/list';
  static const usersPath = '/users';

  // query
  static const usernameQuery = 'username';

  // header
  static const requestIdempotencyToken = 'x-request-idempotency-token';
}
