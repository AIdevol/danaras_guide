import 'dart:io';
import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;

  NetworkException({
    required this.message,
    this.code,
    this.statusCode,
  });

  static NetworkException getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return NetworkException(
                message: 'Request cancelled',
                code: 'REQUEST_CANCELLED',
                statusCode: 499,
              );

            case DioExceptionType.connectionTimeout:
              return NetworkException(
                message: 'Connection timeout',
                code: 'CONNECTION_TIMEOUT',
                statusCode: 408,
              );

            case DioExceptionType.receiveTimeout:
              return NetworkException(
                message: 'Receive timeout',
                code: 'RECEIVE_TIMEOUT',
                statusCode: 408,
              );

            case DioExceptionType.sendTimeout:
              return NetworkException(
                message: 'Send timeout',
                code: 'SEND_TIMEOUT',
                statusCode: 408,
              );

            case DioExceptionType.badResponse:
              switch (error.response?.statusCode) {
                case 400:
                  return NetworkException(
                    message: 'Bad request',
                    code: 'BAD_REQUEST',
                    statusCode: 400,
                  );
                case 401:
                  return NetworkException(
                    message: 'Unauthorized',
                    code: 'UNAUTHORIZED',
                    statusCode: 401,
                  );
                case 403:
                  return NetworkException(
                    message: 'Forbidden',
                    code: 'FORBIDDEN',
                    statusCode: 403,
                  );
                case 404:
                  return NetworkException(
                    message: 'Resource not found',
                    code: 'NOT_FOUND',
                    statusCode: 404,
                  );
                case 500:
                  return NetworkException(
                    message: 'Internal server error',
                    code: 'SERVER_ERROR',
                    statusCode: 500,
                  );
                default:
                  return NetworkException(
                    message: 'Unexpected error occurred',
                    code: 'UNEXPECTED_ERROR',
                    statusCode: error.response?.statusCode,
                  );
              }

            case DioExceptionType.connectionError:
              return NetworkException(
                message: 'No internet connection',
                code: 'CONNECTION_ERROR',
                statusCode: 503,
              );

            case DioExceptionType.badCertificate:
              return NetworkException(
                message: 'Bad certificate',
                code: 'BAD_CERTIFICATE',
                statusCode: 525,
              );

            default:
              return NetworkException(
                message: 'Unexpected error occurred',
                code: 'UNEXPECTED_ERROR',
                statusCode: 500,
              );
          }
        } else if (error is SocketException) {
          return NetworkException(
            message: 'No internet connection',
            code: 'SOCKET_ERROR',
            statusCode: 503,
          );
        } else {
          return NetworkException(
            message: 'Unexpected error occurred',
            code: 'UNEXPECTED_ERROR',
            statusCode: 500,
          );
        }
      } on FormatException catch (_) {
        return NetworkException(
          message: 'Unexpected error occurred',
          code: 'FORMAT_ERROR',
          statusCode: 500,
        );
      } catch (_) {
        return NetworkException(
          message: 'Unexpected error occurred',
          code: 'UNEXPECTED_ERROR',
          statusCode: 500,
        );
      }
    } else {
      return NetworkException(
        message: 'Unexpected error occurred',
        code: 'UNEXPECTED_ERROR',
        statusCode: 500,
      );
    }
  }

  @override
  String toString() => 'NetworkException(message: $message, code: $code, statusCode: $statusCode)';
}