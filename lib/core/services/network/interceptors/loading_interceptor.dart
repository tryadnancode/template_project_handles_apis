import 'package:dio/dio.dart';
import '../../../di/service_locator.dart';
import '../../ui/ui_service.dart';

class LoadingInterceptor extends Interceptor {
  final UiService _uiService = sl<UiService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _uiService.showLoader();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _uiService.hideLoader();
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _uiService.hideLoader();
    super.onError(err, handler);
  }
}
