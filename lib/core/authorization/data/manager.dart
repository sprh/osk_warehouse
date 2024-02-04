import '../../network/dio_client.dart';
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
  Future<void> getCachedToken() async {
    final cachedToken = await _repository.getCachedToken() ??
        await _repository.getTokenByCachedUserCreds();
    if (cachedToken != null) {
      _dio.addInterceptor(TokenInterceptor(token: cachedToken));
      _authorizationDataBloc.setAuthorized();
    } else {
      _authorizationDataBloc.setNotAuthorized();
    }
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
      _dio.addInterceptor(TokenInterceptor(token: token));
      _authorizationDataBloc.setAuthorized();
    } else {
      _authorizationDataBloc.setNotAuthorized();
    }
  }
}
