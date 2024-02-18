import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthorizationDB {
  factory AuthorizationDB(FlutterSecureStorage storage) =>
      _AuthorizationDB(storage);

  Future<String?> getCachedToken();

  Future<void> setToken({required String token});

  Future<(String? username, String? password)> getAuthData();

  Future<void> setAuthData({
    required String username,
    required String password,
  });

  Future<void> clearUserData();
}

class _AuthorizationDB implements AuthorizationDB {
  final FlutterSecureStorage _secureStorage;

  const _AuthorizationDB(this._secureStorage);

  @override
  Future<void> clearUserData() async {
    await _secureStorage.delete(key: _SecureStorageKeys.password);
    await _secureStorage.delete(key: _SecureStorageKeys.token);
    await _secureStorage.delete(key: _SecureStorageKeys.username);
  }

  @override
  Future<(String?, String?)> getAuthData() async => (
        await _secureStorage.read(key: _SecureStorageKeys.username),
        await _secureStorage.read(key: _SecureStorageKeys.password)
      );

  @override
  Future<String?> getCachedToken() =>
      _secureStorage.read(key: _SecureStorageKeys.token);

  @override
  Future<void> setAuthData({
    required String username,
    required String password,
  }) async {
    await _secureStorage.write(
      key: _SecureStorageKeys.username,
      value: username,
    );
    await _secureStorage.write(
      key: _SecureStorageKeys.password,
      value: password,
    );
  }

  @override
  Future<void> setToken({required String token}) => _secureStorage.write(
        key: _SecureStorageKeys.token,
        value: token,
      );
}

class _SecureStorageKeys {
  static const username = 'username';
  static const password = 'password';
  static const token = 'token';
}
