class ApiResponse<T> {
  final T? data;

  ApiResponse.completed(this.data) : assert(data != null);
  ApiResponse.empty() : data = null;
}
