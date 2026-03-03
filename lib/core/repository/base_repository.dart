import 'dart:io';
import 'package:dio/dio.dart';
import '../errors/app_exception.dart';
import 'api_response.dart';

/// The base class for all repositories in the application.
///
/// It provides a standardized way to execute API calls and handle common
/// errors such as network issues, server errors, and no internet connection.
class BaseRepository {
  /// Executes an API call that is expected to return a body.
  ///
  /// [apiCall] is the function that performs the API request.
  /// [parser] is a function that parses the raw JSON data into a type [T].
  ///
  /// Returns an [ApiResponse] containing the parsed data on success.
  /// Throws an [AppException] on failure.
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

  /// Executes an API call that returns a successful response with an empty body.
  ///
  /// [apiCall] is the function that performs the API request.
  ///
  /// Returns an empty [ApiResponse] on success (e.g., 204 No Content).
  /// Throws an [AppException] on failure.
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

  /// Handles and translates [DioException] into a standardized [AppException].
  ///
  /// This private method centralizes all network error handling logic.
  AppException _handleDioException(DioException e) {
    if (e.error is AppException) {
      return e.error as AppException;
    }
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
