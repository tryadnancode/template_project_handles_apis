import 'package:flutter/material.dart';
import 'package:template_project/template_project.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Setup the core architecture
  await setup(env: Environment.dev);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = sl<ThemeService>();

    return ListenableBuilder(
      listenable: themeService,
      builder: (context, _) {
        return MaterialApp(
          title: 'Template Project Example',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeService.themeMode,
          // Use the built-in navigator key from the service locator
          navigatorKey: sl<GlobalKey<NavigatorState>>(),
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}

class ExampleHomeScreen extends StatelessWidget {
  const ExampleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const Text('Example App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppCard(
              child: Text('This is a card from the template!'),
            ),
            const SizedBox(height: 20),
            AppButton(
              text: 'Toggle Theme',
              onPressed: () => sl<ThemeService>().toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
