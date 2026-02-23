import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../di/service_locator.dart';
import '../../log/log_service.dart';

class LoggingInterceptor extends Interceptor {
  final LogService _log = sl<LogService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      _log.info('REQUEST[${options.method}] => PATH: ${options.path}');
      _log.info('Headers: ${options.headers}');
      _log.info('Data: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      _log.info(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      );
      _log.info('Data: ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      _log.error(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      );
      _log.error('Error: ${err.error}');
      _log.error('Message: ${err.message}');
    }
    super.onError(err, handler);
  }
}
