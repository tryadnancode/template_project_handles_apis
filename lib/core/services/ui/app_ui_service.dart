import 'package:flutter/material.dart';
import 'ui_service.dart';

class AppUiService implements UiService {
  final GlobalKey<NavigatorState> navigatorKey;

  AppUiService(this.navigatorKey);

  BuildContext? get _context => navigatorKey.currentContext;

  @override
  void showLoader() {
    if (_context == null) return;

    showDialog(
      context: _context!,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void hideLoader() {
    if (_context == null) return;
    Navigator.of(_context!).pop();
  }

  @override
  void showMessage(String message) {
    if (_context == null) return;

    ScaffoldMessenger.of(_context!).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  void showError(String message) {
    if (_context == null) return;

    ScaffoldMessenger.of(_context!).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
