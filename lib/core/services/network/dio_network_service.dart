import 'package:dio/dio.dart';
import '../../di/service_locator.dart';
import '../log/log_service.dart';
import 'network_service.dart';

class DioNetworkService implements NetworkService {
  final Dio dio;
  final LogService log = sl<LogService>();

  DioNetworkService(this.dio);

  @override
  Future<Response> get(String path, {Map<String, dynamic>? query}) {
    log.info("GET => $path");
    return dio.get(path, queryParameters: query);
  }

  @override
  Future<Response> post(String path, {body}) {
    log.info("POST => $path");
    return dio.post(path, data: body);
  }

  @override
  Future<Response> put(String path, {body}) {
    log.info("PUT => $path");
    return dio.put(path, data: body);
  }

  @override
  Future<Response> delete(String path, {body}) {
    log.info("DELETE => $path");
    return dio.delete(path, data: body);
  }
}
