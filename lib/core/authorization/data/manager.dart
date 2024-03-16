import '../../network/dio_client.dart';
import '../../network/interceptors/expired_token_interceptor.dart';
import '../../network/interceptors/token_interceptor.dart';
import '../bloc/authorization_data_bloc.dart';
import 'repository.dart';

abstract class AuthorizationDataManager {
  factory AuthorizationDataManager(
    DioClient dio,
    AuthorizationRepository repository,
    AuthorizationDataBloc authorizationDataBloc,
  ) =>
      _AuthorizationDataManager(
        dio,
        repository,
        authorizationDataBloc,
      );

  CurrentUsernameHolder get currentUsernameHolder;

  Future<void> getCachedToken();

  Future<void> getToken({
    required String username,
    required String password,
  });
}

class _AuthorizationDataManager implements AuthorizationDataManager {
  final DioClient _dio;
  final AuthorizationRepository _repository;
  final AuthorizationDataBloc _authorizationDataBloc;

  const _AuthorizationDataManager(
    this._dio,
    this._repository,
    this._authorizationDataBloc,
  );

  @override
  CurrentUsernameHolder get currentUsernameHolder => _authorizationDataBloc;

  @override
  Future<void> getCachedToken() async {
    final cachedToken = await _repository.getCachedToken() ??
        await _repository.getTokenByCachedUserCreds();
    if (cachedToken != null) {
      final username = await _repository.username;
      if (username != null) {
        _addInterceptors(cachedToken);
        _authorizationDataBloc.setAuthorized(username: username);
        return;
      }
    }

    _authorizationDataBloc.setNotAuthorized();
    _removeInterceptors();
  }

  @override
  Future<void> getToken({
    required String username,
    required String password,
  }) async {
    final token = await _repository.refreshToken(
      username: username,
      password: password,
    );
    if (token != null) {
      _addInterceptors(token);
      _authorizationDataBloc.setAuthorized(username: username);
    } else {
      _authorizationDataBloc.setNotAuthorized();
      _removeInterceptors();
    }
  }

  void _addInterceptors(String token) => _dio
    ..addInterceptor(TokenInterceptor(token: token))
    ..addInterceptor(
      ExpiredTokenInterceptor(
        refreshToken: () async {
          final token = await _repository.getTokenByCachedUserCreds();
          if (token != null) {
            _dio
              ..removeInterceptorWhere((it) => it is TokenInterceptor)
              ..addInterceptor(TokenInterceptor(token: token));
          } else {
            _removeInterceptors();
            _authorizationDataBloc.setNotAuthorized();
          }

          return token != null;
        },
        retry: _dio.retry,
        needRetry: (url, statusCode) {
          final needRetry = _repository.needRetryUrl(url, statusCode);
          if (!needRetry) {
            _removeInterceptors();
            _authorizationDataBloc.setNotAuthorized();
          }
          return needRetry;
        },
      ),
    );

  void _removeInterceptors() => _dio
    ..removeInterceptorWhere((it) => it is TokenInterceptor)
    ..removeInterceptorWhere(
      (it) => it is ExpiredTokenInterceptor,
    );
}
