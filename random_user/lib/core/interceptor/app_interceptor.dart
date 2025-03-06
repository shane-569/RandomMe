import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AppInterceptor extends Interceptor {
  final Logger _logger = Logger(); // Initialize logger

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i('--> ${options.method} ${options.uri}'); // Log request
    _logger.i('Headers: ${options.headers}');
    if (options.queryParameters.isNotEmpty) {
      _logger.i('Query Parameters: ${options.queryParameters}');
    }
    if (options.data != null) {
      _logger.i('Body: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i(
        '<-- ${response.statusCode} ${response.requestOptions.uri}'); // Log response
    _logger.i('Response: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('<-- Error -->');
    _logger.e('URI: ${err.requestOptions.uri}');
    _logger.e('$err');
    _logger.e('Response: ${err.response?.data}');
    super.onError(err, handler);
  }
}
