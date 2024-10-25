import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:banaras_guide/services/custome_token_manager.dart';
import 'package:banaras_guide/services/exception_class.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_dio/fresh_dio.dart'; // Import fresh_dio package
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure storage

// Custom implementation of TokenStor

class ApiClient {
  static const Duration defaultTimeout = Duration(minutes: 1);
  static const String contentType = 'application/json';
  
  late final Dio _dio;
  late final Fresh<String> _fresh;
  final String baseUrl;
  final CustomTokenStorage tokenStorage;
  
  ApiClient( {
    required this.baseUrl,dio,
    List<Interceptor>? interceptors,
  }) : tokenStorage = CustomTokenStorage() {
    _dio = _createDio(interceptors);
    _fresh = _setupTokenRefresh();
    _dio.interceptors.add(_fresh);
  }

  Dio _createDio(List<Interceptor>? interceptors) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: defaultTimeout,
      receiveTimeout: defaultTimeout,
      contentType: contentType,
      headers: {'Content-Type': contentType},
      validateStatus: (status) => status! < 500,
    ));

    if (interceptors?.isNotEmpty ?? false) {
      dio.interceptors.addAll(interceptors!);
    }

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: false,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ));
    }

    if (!kIsWeb) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = 
        (client) => _configureHttpClient(client);
    }

    return dio;
  }

  HttpClient _configureHttpClient(HttpClient client) {
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  }

  Fresh<String> _setupTokenRefresh() {
    return Fresh<String>(
      tokenStorage: tokenStorage,
      refreshToken: (token, client) async {
        try {
          final refreshToken = await tokenStorage.readRefreshToken();
          if (refreshToken == null) throw RevokeTokenException();

          final response = await _dio.post(
            '/auth/refresh',
            data: {'refresh_token': refreshToken},
          );

          if (response.statusCode == 200 && response.data['access_token'] != null) {
            // Store the new tokens
            await tokenStorage.write(response.data['access_token']);
            if (response.data['refresh_token'] != null) {
              await tokenStorage.writeRefreshToken(response.data['refresh_token']);
            }
            return response.data['access_token'];
          }
          throw RevokeTokenException();
        } catch (e) {
          // Clear tokens on error
          await tokenStorage.delete();
          await tokenStorage.deleteRefreshToken();
          throw RevokeTokenException();
        }
      },
      shouldRefresh: (response) {
        return response?.statusCode == 401;
      },
      tokenHeader: (token) {
        return {'Authorization': 'Bearer $token'};
      },
    );
  }

  Future<T> _handleRequest<T>({
    required Future<Response<T>> Function() request,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await request();
      return response.data as T;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on FormatException {
      throw const ApiException('Unable to process the data');
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException('Connection timeout');
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.connectionError:
        return const ApiException('No internet connection');
      default:
        return ApiException(error.message ?? 'Unknown error occurred');
    }
  }

  Exception _handleBadResponse(Response? response) {
    switch (response?.statusCode) {
      case 400:
        return ApiException('Bad request: ${response?.data?['message']}');
      case 401:
        return const UnauthorizedException();
      case 403:
        return const ForbiddenException();
      case 404:
        return const NotFoundException();
      default:
        return ApiException('Server error: ${response?.statusCode}');
    }
  }

  // HTTP Methods
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _handleRequest<T>(
      requiresAuth: requiresAuth,
      request: () => _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _handleRequest<T>(
      requiresAuth: requiresAuth,
      request: () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _handleRequest<T>(
      requiresAuth: requiresAuth,
      request: () => _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
    CancelToken? cancelToken,
  }) async {
    return _handleRequest<T>(
      requiresAuth: requiresAuth,
      request: () => _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }
}

// Exception classes
