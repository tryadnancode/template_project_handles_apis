import 'dart:developer';
import 'log_service.dart';

class ConsoleLogService implements LogService {

  String _time() => DateTime.now().toIso8601String();

  @override
  void debug(String message) {
    log("🐞 DEBUG | ${_time()} | $message");
  }

  @override
  void info(String message) {
    log("ℹ️ INFO  | ${_time()} | $message");
  }

  @override
  void warning(String message) {
    log("⚠️ WARN  | ${_time()} | $message");
  }

  @override
  void error(String message) {
    log("❌ ERROR | ${_time()} | $message");
  }
}