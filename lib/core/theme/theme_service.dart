import 'package:flutter/material.dart';
import '../di/service_locator.dart';
import '../services/storage/storage_service.dart';

class ThemeService extends ChangeNotifier {
  final StorageService _storage = sl<StorageService>();
  static const String _themeKey = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  Future<void> init() async {
    final savedTheme = _storage.get(_themeKey);
    if (savedTheme != null) {
      _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    await _storage.set(
      _themeKey,
      _themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
    notifyListeners();
  }
}
