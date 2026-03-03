import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../config/app_config.dart';
import '../services/connectivity/connectivity_service.dart';
import '../services/connectivity/connectivity_service_impl.dart';
import '../services/log/log_service.dart';
import '../services/log/console_log_service.dart';
import '../services/network/interceptors/auth_interceptor.dart';
import '../services/network/interceptors/connectivity_interceptor.dart';
import '../services/network/interceptors/error_interceptor.dart';
import '../services/network/interceptors/loading_interceptor.dart';
import '../services/network/interceptors/logging_interceptor.dart';
import '../services/ui/app_ui_service.dart';
import '../services/ui/ui_service.dart';
import '../services/network/network_service.dart';
import '../services/network/dio_network_service.dart';
import '../services/storage/storage_service.dart';
import '../services/storage/shared_preferences_storage_service.dart';
import '../theme/theme_service.dart';

final sl = GetIt.instance;

Future<void> setup({Environment env = Environment.dev}) async {
  // Config
  sl.registerSingleton(AppConfig.dev());

  // Core Services
  final navigatorKey = GlobalKey<NavigatorState>();
  sl.registerSingleton(navigatorKey);
  sl.registerSingleton<LogService>(ConsoleLogService());
  sl.registerSingleton<UiService>(AppUiService(navigatorKey));
  sl.registerSingleton<ConnectivityService>(ConnectivityServiceImpl());

  // Storage - Initialize and register synchronously
  final storageService = SharedPreferencesStorageService();
  await storageService.init();
  sl.registerSingleton<StorageService>(storageService);

  // Theme - Initialize and register synchronously
  final themeService = ThemeService();
  await themeService.init();
  sl.registerSingleton<ThemeService>(themeService);

  // Dio and Network
  final dio = Dio(
    BaseOptions(
      baseUrl: sl<AppConfig>().baseUrl,
      connectTimeout: const Duration(seconds: 30),
    ),
  );

  dio.interceptors.addAll([
    ConnectivityInterceptor(),
    LoadingInterceptor(),
    LoggingInterceptor(),
    AuthInterceptor(),
    ErrorInterceptor(),
  ]);

  sl.registerSingleton<NetworkService>(DioNetworkService(dio));
}
