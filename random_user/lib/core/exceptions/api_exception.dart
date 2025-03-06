import 'package:dio/dio.dart';

enum ApiErrorType {
  network,
  server,
  unauthorized,
  forbidden,
  notFound,
  validation,
  timeout,
  unknown,
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;
  final ApiErrorType type;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
    this.type = ApiErrorType.unknown,
  });

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Connection timeout',
          statusCode: error.response?.statusCode,
          type: ApiErrorType.timeout,
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        return ApiException(
          message: 'Request cancelled',
          statusCode: error.response?.statusCode,
          type: ApiErrorType.unknown,
        );
      default:
        return ApiException(
          message: 'Network error occurred',
          statusCode: error.response?.statusCode,
          type: ApiErrorType.network,
        );
    }
  }

  static ApiException _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;
    final message = response?.statusMessage ?? 'Unknown error occurred';

    switch (statusCode) {
      case 400:
        return ApiException(
          message: 'Bad request: $message',
          statusCode: statusCode,
          data: data,
          type: ApiErrorType.validation,
        );
      case 401:
        return ApiException(
          message: 'Unauthorized: $message',
          statusCode: statusCode,
          data: data,
          type: ApiErrorType.unauthorized,
        );
      case 403:
        return ApiException(
          message: 'Forbidden: $message',
          statusCode: statusCode,
          data: data,
          type: ApiErrorType.forbidden,
        );
      case 404:
        return ApiException(
          message: 'Not found: $message',
          statusCode: statusCode,
          data: data,
          type: ApiErrorType.notFound,
        );
      case 500:
        return ApiException(
          message: 'Server error: $message',
          statusCode: statusCode,
          data: data,
          type: ApiErrorType.server,
        );
      default:
        return ApiException(
          message: message,
          statusCode: statusCode,
          data: data,
          type: ApiErrorType.unknown,
        );
    }
  }

  @override
  String toString() =>
      'ApiException: $message (Type: $type, Status Code: $statusCode)';
}
