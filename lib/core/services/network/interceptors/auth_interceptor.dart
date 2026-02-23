import 'package:dio/dio.dart';
import '../../../di/service_locator.dart';
import '../../storage/storage_service.dart';

class AuthInterceptor extends Interceptor {
  final StorageService _storageService = sl<StorageService>();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = _storageService.get('token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
