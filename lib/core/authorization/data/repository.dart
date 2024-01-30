import 'package:dio/dio.dart';

import '../../network/dio_client.dart';
import 'db.dart';

abstract class AuthorizationRepository {
  factory AuthorizationRepository(
    AuthorizationDB db,
    DioClient dio,
  ) =>
      _AuthorizationRepository(db, dio);

  Future<String?> refreshToken({
    required String username,
    required String password,
  });

  Future<String?> getCachedToken();

  Future<String?> getCachedTokenByUserCreds();
}

class _AuthorizationRepository implements AuthorizationRepository {
  final AuthorizationDB _db;
  final DioClient _dio;

  const _AuthorizationRepository(this._db, this._dio);

  @override
  Future<String?> getCachedToken() => _db.getCachedToken();

  @override
  Future<String?> refreshToken({
    required String username,
    required String password,
  }) async {
    final token = await _dio.core.post<Map<String, dynamic>>(
      _AuthorizationApiConstants.tokenPath,
      data: {
        'username': username, // TODO: models
        'password': password,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );

    final accessToken = token.data?['access_token'] as String?;
    if (accessToken != null) {
      await _db.setAuthData(username: username, password: password);
      await _db.setToken(token: accessToken);
    }

    return accessToken;
  }

  @override
  Future<String?> getCachedTokenByUserCreds() async {
    final (username, password) = await _db.getAuthData();
    if (username != null && password != null) {
      return refreshToken(password: password, username: username);
    }

    return null;
  }
}

class _AuthorizationApiConstants {
  static const tokenPath = '/token';
}
