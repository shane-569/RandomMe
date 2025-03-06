import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../exceptions/api_exception.dart';
import 'dart:convert';

class AppInterceptor extends Interceptor {
  final Logger _logger;
  final bool _logRequest;
  final bool _logResponse;
  final bool _logError;
  final bool _logTiming;
  final bool _prettyPrint;

  AppInterceptor({
    bool logRequest = true,
    bool logResponse = true,
    bool logError = true,
    bool logTiming = true,
    bool prettyPrint = true,
    Logger? logger,
  })  : _logRequest = logRequest,
        _logResponse = logResponse,
        _logError = logError,
        _logTiming = logTiming,
        _prettyPrint = prettyPrint,
        _logger = logger ??
            Logger(
              printer: PrettyPrinter(
                methodCount: 0,
                errorMethodCount: 8,
                lineLength: 120,
                colors: true,
                printEmojis: true,
                printTime: true,
              ),
            );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_logRequest) {
      super.onRequest(options, handler);
      return;
    }

    final requestTime = DateTime.now();
    options.extra['requestTime'] = requestTime;

    _logger.i('🌐 REQUEST: ${options.method} ${options.uri}');
    _logHeaders(options.headers);
    _logQueryParameters(options.queryParameters);
    _logBody(options.data);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!_logResponse) {
      super.onResponse(response, handler);
      return;
    }

    final requestTime =
        response.requestOptions.extra['requestTime'] as DateTime?;
    final duration = requestTime != null
        ? DateTime.now().difference(requestTime).inMilliseconds
        : null;

    _logger
        .i('✅ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
    if (_logTiming && duration != null) {
      _logger.i('⏱️ Duration: ${duration}ms');
    }
    _logResponseData(response.data);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!_logError) {
      super.onError(err, handler);
      return;
    }

    final apiException = ApiException.fromDioError(err);
    final requestTime = err.requestOptions.extra['requestTime'] as DateTime?;
    final duration = requestTime != null
        ? DateTime.now().difference(requestTime).inMilliseconds
        : null;

    _logger.e('❌ ERROR: ${apiException.type}');
    _logger.e('URI: ${err.requestOptions.uri}');
    _logger.e('Message: ${apiException.message}');
    _logger.e('Status Code: ${apiException.statusCode}');

    if (_logTiming && duration != null) {
      _logger.e('⏱️ Duration: ${duration}ms');
    }

    if (apiException.data != null) {
      _logErrorData(apiException.data);
    }

    _logRequestDetails(err.requestOptions);

    super.onError(err, handler);
  }

  void _logHeaders(Map<String, dynamic> headers) {
    if (headers.isNotEmpty) {
      _logger.i('Headers: ${_prettyPrint ? _prettyJson(headers) : headers}');
    }
  }

  void _logQueryParameters(Map<String, dynamic> parameters) {
    if (parameters.isNotEmpty) {
      _logger.i(
          'Query Parameters: ${_prettyPrint ? _prettyJson(parameters) : parameters}');
    }
  }

  void _logBody(dynamic data) {
    if (data != null) {
      _logger.i('Body: ${_prettyPrint ? _prettyJson(data) : data}');
    }
  }

  void _logResponseData(dynamic data) {
    if (data != null) {
      _logger.i('Response Data: ${_prettyPrint ? _prettyJson(data) : data}');
    }
  }

  void _logErrorData(dynamic data) {
    _logger.e('Error Data: ${_prettyPrint ? _prettyJson(data) : data}');
  }

  void _logRequestDetails(RequestOptions options) {
    _logger.d('Request Method: ${options.method}');
    _logHeaders(options.headers);
    _logQueryParameters(options.queryParameters);
    _logBody(options.data);
  }

  String _prettyJson(dynamic data) {
    try {
      if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
      return data.toString();
    } catch (e) {
      return data.toString();
    }
  }
}
