import 'package:dio/dio.dart';

class ExpiredTokenInterceptor extends Interceptor {
  final Future<bool> Function() refreshToken;
  final Future<Response<dynamic>> Function(RequestOptions) retry;

  const ExpiredTokenInterceptor({
    required this.refreshToken,
    required this.retry,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      if (await refreshToken()) {
        handler.resolve(await retry(err.requestOptions));
      }
    }
    super.onError(err, handler);
  }
}
