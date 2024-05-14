import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:osk_warehouse/core/network/interceptors/expired_token_interceptor.dart';

import 'expired_token_interceptor_test.mocks.dart';

@GenerateMocks([
  ErrorInterceptorHandler,
])
class MockExpiredTokenInterceptor extends ExpiredTokenInterceptor {
  MockExpiredTokenInterceptor({
    required super.needRetry,
    required super.refreshToken,
    required super.retry,
  });
}

void main() {
  late ExpiredTokenInterceptor interceptor;
  late MockErrorInterceptorHandler mockHandler;

  setUp(() {
    mockHandler = MockErrorInterceptorHandler();
  });

  test('onError handles 401 and calls refreshToken', () async {
    final dioException = DioException(
      requestOptions: RequestOptions(path: '/test'),
      response: Response(
        statusCode: 401,
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    Future<bool> mockRefreshToken() async => true;

    Future<Response<Map<String, dynamic>>> mockRetry(
      RequestOptions options,
    ) async =>
        Response(data: {}, requestOptions: options);

    interceptor = MockExpiredTokenInterceptor(
      needRetry: (url, statusCode) => statusCode == 401,
      refreshToken: mockRefreshToken,
      retry: mockRetry,
    );

    await interceptor.onError(dioException, mockHandler);

    verify(mockHandler.resolve(any)).called(1);
  });

  test('onError handles 401 but refreshToken fails', () async {
    final dioException = DioException(
      requestOptions: RequestOptions(path: '/test'),
      response: Response(
        statusCode: 401,
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    Future<bool> mockRefreshToken() async => false;

    interceptor = MockExpiredTokenInterceptor(
      needRetry: (url, statusCode) => statusCode == 401,
      refreshToken: mockRefreshToken,
      retry: (_) async =>
          throw DioException(requestOptions: RequestOptions(path: '/test')),
    );

    await interceptor.onError(dioException, mockHandler);

    verify(mockHandler.next(dioException)).called(1);
  });

  test('onError do not retry if needRetry returns false even for 401',
      () async {
    final dioException = DioException(
      requestOptions: RequestOptions(path: '/test'),
      response: Response(
        statusCode: 401,
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    interceptor = MockExpiredTokenInterceptor(
      needRetry: (url, statusCode) => url != '/test',
      refreshToken: () async => true,
      retry: (_) async => throw DioException(
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    await interceptor.onError(dioException, mockHandler);

    verifyNever(mockHandler.next(dioException));
  });

  test('onError does not handle non-401 errors', () async {
    final dioException = DioException(
      requestOptions: RequestOptions(path: '/test'),
      response: Response(
        statusCode: 500,
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    interceptor = ExpiredTokenInterceptor(
      needRetry: (url, statusCode) => statusCode == 401,
      refreshToken: () async => true,
      retry: (_) async => Response(
        data: <String, dynamic>{},
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    await interceptor.onError(dioException, mockHandler);

    verifyNever(mockHandler.next(dioException));
  });
}
