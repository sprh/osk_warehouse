import '../../network/dio_client.dart';
import '../../network/interceptors/token_interceptor.dart';
import 'repository.dart';

abstract class AuthorizationDataManager {
  factory AuthorizationDataManager(
    DioClient dio,
    AuthorizationRepository repository,
  ) =>
      _AuthorizationDataManager(dio, repository);

  Future<bool> getCachedToken();

  Future<bool> getToken({
    required String username,
    required String password,
  });
}

class _AuthorizationDataManager implements AuthorizationDataManager {
  final DioClient _dio;
  final AuthorizationRepository _repository;

  const _AuthorizationDataManager(this._dio, this._repository);

  @override
  Future<bool> getCachedToken() async {
    final cachedToken = await _repository.getCachedToken() ??
        await _repository.getCachedTokenByUserCreds();
    if (cachedToken != null) {
      _dio.addInterceptor(TokenInterceptor(token: cachedToken));
      return true;
    }
    return false;
  }

  @override
  Future<bool> getToken({
    required String username,
    required String password,
  }) async {
    final token = await _repository.refreshToken(
      username: username,
      password: password,
    );
    if (token != null) {
      _dio.addInterceptor(TokenInterceptor(token: token));
      return true;
    }
    return false;
  }
}
