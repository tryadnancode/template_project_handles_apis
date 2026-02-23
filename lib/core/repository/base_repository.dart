import 'dart:io';
import 'package:dio/dio.dart';
import '../errors/app_exception.dart';
import 'api_response.dart';

class BaseRepository {
  Future<ApiResponse<T>> execute<T>(
    Future<Response> Function() apiCall,
    T Function(dynamic json) parser,
  ) async {
    try {
      final response = await apiCall();
      if (response.data == null) {
        throw AppException('Response data is null', response.statusCode);
      }
      return ApiResponse.completed(parser(response.data));
    } on DioException catch (e) {
      throw _handleDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<ApiResponse<void>> executeWithoutResponse(
    Future<Response> Function() apiCall,
  ) async {
    try {
      await apiCall();
      return ApiResponse.empty();
    } on DioException catch (e) {
      throw _handleDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  AppException _handleDioException(DioException e) {
    if (e.error is SocketException) {
      return AppException('No internet connection', 503);
    }
    if (e.response != null) {
      return AppException(
        e.response!.data?['error'] ?? 'An unknown error occurred',
        e.response!.statusCode,
      );
    } else {
      return AppException(e.message ?? "Network Error");
    }
  }
}
