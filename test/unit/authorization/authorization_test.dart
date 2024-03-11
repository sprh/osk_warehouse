import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:osk_warehouse/core/authorization/bloc/authorization_data_bloc.dart';
import 'package:osk_warehouse/core/authorization/data/db.dart';
import 'package:osk_warehouse/core/authorization/data/manager.dart';
import 'package:osk_warehouse/core/authorization/data/repository.dart';
import 'package:osk_warehouse/core/network/dio_client.dart';

import 'authorization_test.mocks.dart';

@GenerateMocks([
  FlutterSecureStorage,
  DioClient,
  AuthorizationRepository,
  AuthorizationDataBloc,
])
void main() {
  group('AuthorizationDB Tests', () {
    late MockFlutterSecureStorage mockStorage;
    late AuthorizationDB authorizationDB;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      authorizationDB = AuthorizationDB(mockStorage);
    });

    test('setToken saves the token', () async {
      const token = 'dummy_token';
      await authorizationDB.setToken(token: token);
      verify(mockStorage.write(key: SecureStorageKeys.token, value: token))
          .called(1);
    });

    test('getCachedToken retrieves the token', () async {
      const token = 'dummy_token';
      when(mockStorage.read(key: SecureStorageKeys.token))
          .thenAnswer((_) async => token);
      final result = await authorizationDB.getCachedToken();
      expect(result, equals(token));
    });

    test('setAuthData saves username and password', () async {
      const username = 'user';
      const password = 'pass';
      await authorizationDB.setAuthData(
        username: username,
        password: password,
      );
      verify(
        mockStorage.write(
          key: SecureStorageKeys.username,
          value: username,
        ),
      ).called(1);
      verify(
        mockStorage.write(
          key: SecureStorageKeys.password,
          value: password,
        ),
      ).called(1);
    });

    test('getAuthData retrieves username and password', () async {
      const username = 'user';
      const password = 'pass';
      when(mockStorage.read(key: SecureStorageKeys.username))
          .thenAnswer((_) async => username);
      when(mockStorage.read(key: SecureStorageKeys.password))
          .thenAnswer((_) async => password);
      final result = await authorizationDB.getAuthData();
      expect(result, equals((username, password)));
    });

    test('clearUserData clears the data', () async {
      await authorizationDB.clearUserData();
      verify(mockStorage.delete(key: SecureStorageKeys.username)).called(1);
      verify(mockStorage.delete(key: SecureStorageKeys.password)).called(1);
      verify(mockStorage.delete(key: SecureStorageKeys.token)).called(1);
    });
  });

  group('AuthorizationDataManager Tests', () {
    late MockDioClient mockDio;
    late MockAuthorizationRepository mockRepository;
    late MockAuthorizationDataBloc mockBloc;
    late AuthorizationDataManager manager;

    setUp(() {
      // Initialize mocks
      mockDio = MockDioClient();
      mockRepository = MockAuthorizationRepository();
      mockBloc = MockAuthorizationDataBloc();

      // Create the manager with the mocks
      manager = AuthorizationDataManager(mockDio, mockRepository, mockBloc);
    });

    test('getCachedToken should set authorized state if token found', () async {
      // Arrange: Set up the mocks to return a token
      when(mockRepository.getCachedToken())
          .thenAnswer((_) async => 'mock_token');
      when(mockRepository.username).thenAnswer((_) async => 'user');

      // Act: Call the method under test
      await manager.getCachedToken();

      // Assert: Verify the interactions
      verify(mockBloc.setAuthorized(username: anyNamed('username'))).called(1);
      verifyNever(mockBloc.setNotAuthorized());

      // Optionally verify that interceptors are added, depending on your project setup
    });
  });
}
