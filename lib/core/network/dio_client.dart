import 'package:dio/dio.dart';

abstract class DioClient {
  Dio get core;

  factory DioClient(Dio dio) => _DioClient(dio);

  void initialize();

  void addInterceptor(Interceptor interceptor);

  void removeInterceptorWhere(bool Function(Interceptor element) test);
}

class _DioClient implements DioClient {
  final Dio _core;

  const _DioClient(this._core);

  @override
  Dio get core => _core;

  @override
  void addInterceptor(Interceptor interceptor) =>
      _core.interceptors.add(interceptor);

  @override
  void removeInterceptorWhere(bool Function(Interceptor element) test) =>
      _core.interceptors.removeWhere(test);

  @override
  void initialize() {
    _core
      ..options = BaseOptions(
        // ignore: avoid_redundant_argument_values
        baseUrl: const String.fromEnvironment('base_url'),
      )
      ..interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
        ),
      );
  }
}
