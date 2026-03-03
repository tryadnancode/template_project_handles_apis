/// A standard wrapper for all API responses in the application.
///
/// It encapsulates the data returned from the server or represents an empty
/// success state (e.g., 204 No Content).
class ApiResponse<T> {
  /// The data returned from the API, if any.
  final T? data;

  /// Creates a successful response with the given [data].
  ///
  /// [data] must not be null.
  ApiResponse.completed(this.data) : assert(data != null);

  /// Creates a successful response with no data.
  ///
  /// Used for API calls that return an empty body (e.g., 204 No Content).
  ApiResponse.empty() : data = null;
}
