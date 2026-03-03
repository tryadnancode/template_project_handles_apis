# Flutter Robust Starter

A robust, production-ready Flutter starter architecture package. It provides a pre-configured foundation with **Dio**, **GetIt**, **Connectivity Checks**, and **Clean Architecture** patterns, allowing you to skip the boilerplate and start building features immediately.

---

## ✨ Features

- **Robust API Handling:** Centralized error handling and proactive connectivity checks.
- **Dependency-Lean Navigation:** Uses Flutter's native Navigator 2.0.
- **Scalable Dependency Injection:** Pre-configured with `get_it`.
- **Flexible Theming:** Built-in `ThemeService` with persistence support.
- **Rich Widget Library:** Enhanced, reusable widgets (`AppButton`, `AppCard`, etc.).
- **Un-opinionated State Management:** Works with BLoC, Provider, Riverpod, or any other pattern.

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_robust_starter: ^1.1.0
```

Or run:
```sh
flutter pub add flutter_robust_starter
```

---

## 🚀 Quick Start

### 1. Initialize Core Services
In your `main.dart`, call `setup()` to initialize DI, Storage, and Theme services.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_robust_starter/flutter_robust_starter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize all core services
  await setup(env: Environment.dev);

  runApp(const MyApp());
}
```

### 2. Configure MaterialApp
Wrap your app with `ListenableBuilder` to handle theme changes automatically.

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = sl<ThemeService>();

    return ListenableBuilder(
      listenable: themeService,
      builder: (context, _) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeService.themeMode,
          navigatorKey: sl<GlobalKey<NavigatorState>>(),
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
```

---

## 🏛️ Core Components

### BaseRepository (The Powerhouse)
Handle API calls with zero boilerplate. It automatically manages connectivity checks, error conversion, and global loading states.

```dart
class MyRepository extends BaseRepository {
  final NetworkService _network = sl<NetworkService>();

  Future<ApiResponse<User>> getUser(String id) {
    return execute(
      () => _network.get('/users/$id'),
      (json) => UserModel.fromJson(json),
    );
  }
}
```

### Proactive Connectivity
The package includes a `ConnectivityInterceptor` that stops network requests immediately if the device is offline, saving battery and improving user experience.

### Theme Management
A built-in `ThemeService` that persists the user's choice (Light/Dark) using `SharedPreferences`. Toggle it anywhere:
```dart
sl<ThemeService>().toggleTheme();
```

### Form Validation
Centralized validators for common fields:
```dart
AppTextField(
  hintText: 'Email',
  validator: AppValidators.email,
),
```

---

## 🛠️ Customization
Update your environment settings in `AppConfig`:
```dart
sl<AppConfig>().baseUrl; // Accessed globally
```

## 📜 License
This project is licensed under the MIT License - see the LICENSE file for details.
