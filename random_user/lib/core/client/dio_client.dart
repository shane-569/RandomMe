import 'package:dio/dio.dart';

import '../interceptor/app_interceptor.dart';
import '../exceptions/api_exception.dart';

class DioClient {
  final String baseUrl;
  final Dio dio;
  final List<Interceptor>? interceptors;

  DioClient({
    required this.baseUrl,
    required this.dio,
    this.interceptors,
  }) {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 15);
    dio.options.sendTimeout = const Duration(seconds: 15);
    dio.options.validateStatus = (status) => status != null && status < 500;
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    if (interceptors?.isNotEmpty ?? false) {
      dio.interceptors.addAll(interceptors!);
    }
    dio.interceptors.add(AppInterceptor()); // Add AppInterceptor by default
  }

  Future<Response> _handleResponse(Response response) async {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response;
    } else {
      throw ApiException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
        ),
      );
    }
  }

  Future<Response> _handleError(dynamic error) async {
    if (error is DioException) {
      throw ApiException.fromDioError(error);
    }
    throw ApiException(
      message: error.toString(),
      type: ApiErrorType.unknown,
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return await _handleResponse(response);
    } catch (e) {
      return await _handleError(e);
    }
  }

  Future<Response> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return await _handleResponse(response);
    } catch (e) {
      return await _handleError(e);
    }
  }

  Future<Response> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return await _handleResponse(response);
    } catch (e) {
      return await _handleError(e);
    }
  }

  Future<Response> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return await _handleResponse(response);
    } catch (e) {
      return await _handleError(e);
    }
  }
}
