import 'package:dio/dio.dart';
import '../../../di/service_locator.dart';
import '../../../errors/app_exception.dart';
import '../../connectivity/connectivity_service.dart';

class ConnectivityInterceptor extends Interceptor {
  final ConnectivityService _connectivityService = sl<ConnectivityService>();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!await _connectivityService.isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: AppException('No internet connection', 503),
        ),
      );
    }
    super.onRequest(options, handler);
  }
}
