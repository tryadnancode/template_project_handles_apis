import 'package:dio/dio.dart';

abstract class NetworkService {
  Future<Response> get(String path, {Map<String, dynamic>? query});

  Future<Response> post(String path, {dynamic body});

  Future<Response> put(String path, {dynamic body});

  Future<Response> delete(String path, {dynamic body});
}
