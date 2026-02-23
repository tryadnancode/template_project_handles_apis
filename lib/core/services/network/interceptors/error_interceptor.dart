import 'package:dio/dio.dart';
import '../../../di/service_locator.dart';
import '../../log/log_service.dart';

class ErrorInterceptor extends Interceptor {
  final LogService _log = sl<LogService>();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log.error('Dio Error: ${err.message}');
    // You can add logic here to handle specific status codes,
    // like 401 for unauthorized access (e.g., to trigger a token refresh).
    super.onError(err, handler);
  }
}
