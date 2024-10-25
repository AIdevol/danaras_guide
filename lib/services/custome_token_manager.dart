import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';

class CustomTokenStorage implements TokenStorage<String> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  @override
  Future<String?> read() async {
    return await _storage.read(key: _tokenKey);
  }

  @override
  Future<void> write(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  @override
  Future<void> delete() async {
    await _storage.delete(key: _tokenKey);
  }

  // Additional methods for refresh token
  Future<String?> readRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> writeRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshTokenKey);
  }
}