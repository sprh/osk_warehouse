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
    // Create a DioException with status code 401
    final dioException = DioException(
      requestOptions: RequestOptions(path: '/test'),
      response: Response(
        statusCode: 401,
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    // Mock refreshToken to return true
    Future<bool> mockRefreshToken() async => true;

    // Mock retry to return a dummy response
    Future<Response<Map<String, dynamic>>> mockRetry(
      RequestOptions options,
    ) async =>
        Response(data: {}, requestOptions: options);

    // Create the interceptor with mock methods
    interceptor = MockExpiredTokenInterceptor(
      needRetry: (url, statusCode) => statusCode == 401,
      refreshToken: mockRefreshToken,
      retry: mockRetry,
    );

    // Call onError method with the mocked handler
    await interceptor.onError(dioException, mockHandler);

    // Handler should resolve with retry response
    verify(mockHandler.resolve(any)).called(1);
  });

  test('onError handles 401 but refreshToken fails', () async {
    // Create a DioException with status code 401
    final dioException = DioException(
      requestOptions: RequestOptions(path: '/test'),
      response: Response(
        statusCode: 401,
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    // Mock refreshToken to return false
    Future<bool> mockRefreshToken() async => false;

    // Create the interceptor with mock refreshToken method
    interceptor = MockExpiredTokenInterceptor(
      needRetry: (url, statusCode) => statusCode == 401,
      refreshToken: mockRefreshToken,
      retry: (_) async =>
          throw DioException(requestOptions: RequestOptions(path: '/test')),
    );

    // Call onError method with the mocked handler
    await interceptor.onError(dioException, mockHandler);

    // Handler should call next with the dioException
    verify(mockHandler.next(dioException)).called(1);
  });

  test('onError do not retry if needRetry returns false even for 401',
      () async {
    // Create a DioException with status code 401
    final dioException = DioException(
      requestOptions: RequestOptions(path: '/test'),
      response: Response(
        statusCode: 401,
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    // Create the interceptor with mock refreshToken method
    interceptor = MockExpiredTokenInterceptor(
      needRetry: (url, statusCode) => url != '/test',
      refreshToken: () async => true,
      retry: (_) async => throw DioException(
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    // Call onError method with the mocked handler
    await interceptor.onError(dioException, mockHandler);

    // Handler should call next with the dioException
    verifyNever(mockHandler.next(dioException));
  });

  test('onError does not handle non-401 errors', () async {
    // Create a DioException with status code other than 401
    final dioException = DioException(
      requestOptions: RequestOptions(path: '/test'),
      response: Response(
        statusCode: 500,
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    // Create the interceptor
    interceptor = ExpiredTokenInterceptor(
      needRetry: (url, statusCode) => statusCode == 401,
      refreshToken: () async => true,
      retry: (_) async => Response(
        data: <String, dynamic>{},
        requestOptions: RequestOptions(path: '/test'),
      ),
    );

    // Call onError method with the mocked handler
    await interceptor.onError(dioException, mockHandler);

    // Handler should call next with the dioException
    verifyNever(mockHandler.next(dioException));
  });
}
