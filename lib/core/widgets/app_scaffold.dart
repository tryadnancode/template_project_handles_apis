import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool isLoading;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: isLoading ? const Center(child: CircularProgressIndicator()) : body,
    );
  }
}
