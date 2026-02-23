# Flutter Production-Ready Template

A robust, scalable, and un-opinionated starter template for Flutter applications that need to communicate with a REST API. This template provides a powerful architectural foundation so you can focus on building features, not boilerplate.

---

## ✨ Features

- **Clean Architecture:** A clear separation of concerns between presentation, domain, and data layers.
- **Robust API Handling:** A powerful and flexible system for all your networking needs.
- **Dependency-Lean Navigation:** Uses Flutter's native Navigator 2.0 for stable, dependency-free routing.
- **Scalable Dependency Injection:** Pre-configured with `get_it` for managing all your services and blocs.
- **Environment Configuration:** Easily manage `dev`, `staging`, and `prod` environments.
- **Flexible Theming:** A simple and extensible system for managing your app's look and feel, including light and dark modes.
- **Rich Widget Library:** A collection of common, reusable, and enhanced widgets to accelerate UI development.
- **Un-opinionated State Management:** No specific state management pattern is enforced. Use BLoC, Provider, Riverpod, or anything else you prefer.

## 🚀 Getting Started

Follow these steps to start a new project from this template.

### Step 1: Rename Your Project

First, give your project its own identity.

1.  **Open `pubspec.yaml`** and change the `name` property from `demo` to your new project name (e.g., `my_awesome_app`).

2.  **Run a rename package** to update all platform-specific files automatically. Open your terminal and run:
    ```sh
    flutter pub add change_app_package_name
    flutter pub run change_app_package_name:main com.yourcompany.yourappname
    ```

### Step 2: Configure Your API Endpoint

This template is built to handle different API environments.

1.  **Navigate to `lib/core/config/app_config.dart`**.

2.  **Update the production URL:** In the `prod()` static method, replace the placeholder URL with your real production base URL.
    ```dart
    static AppConfig prod() {
      return AppConfig(
        baseUrl: 'https://api.my-real-app.com/v1/', // <-- CHANGE THIS
        environment: Environment.prod,
      );
    }
    ```

### Step 3: Build Your First Feature

This is where the power of the template shines. Let's say you want to build a feature to show a list of "Products".

1.  **Create a Feature Folder:** Inside the `lib` directory, create a new folder: `features/products`.

2.  **Create the Screen:** Inside `features/products`, create the file `presentation/view/products_screen.dart`. This is your feature's main UI.

3.  **Add the Route:** Open `lib/core/routing/app_router.dart` and add a route for your new screen.
    ```dart
    class AppRouter {
      static const String homeRoute = '/';
      static const String productsRoute = '/products'; // <-- ADD THIS

      static Route<dynamic> onGenerateRoute(RouteSettings settings) {
        switch (settings.name) {
          // ...
          case productsRoute: // <-- AND ADD THIS CASE
            return MaterialPageRoute(builder: (_) => const ProductsScreen());
        }
      }
    }
    ```

4.  **Implement Data & State:**
    -   Create your state management logic (e.g., `ProductsCubit`) in `features/products/presentation/bloc/`.
    -   Create your repository (`ProductsRepository`) in `features/products/data/repository/`. **Remember to extend `BaseRepository`** to get automatic error handling.
    -   Create your data source (`ProductsRemoteDataSource`) in `features/products/data/datasources/`.

5.  **Register Dependencies:** Open `lib/core/di/service_locator.dart` and register your new dependencies at the bottom of the `setup()` method.
    ```dart
    // Features
    sl.registerFactory(() => ProductsCubit(sl()));
    sl.registerLazySingleton(() => ProductsUseCase(sl()));
    sl.registerLazySingleton<ProductsRepository>(() => ProductsRepositoryImpl(sl()));
    // ...and so on.
    ```

### Step 4: Set the Starting Screen

Finally, tell the app where to begin.

1.  **Open `lib/main.dart`** and change the `initialRoute` in the `MaterialApp` to your new feature's route.
    ```dart
    return MaterialApp(
      // ...
      initialRoute: AppRouter.productsRoute, // <-- CHANGE THIS
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
    ```

---

## 🏛️ Core Architecture Overview

### API Handling

- **`BaseRepository`:** The cornerstone of the data layer. It provides centralized error handling and response parsing. Extend your repositories from this class.
- **`ApiResponse`:** A wrapper that handles API responses that may or may not contain a body (e.g., `204 No Content`).
- **Dio Interceptors:** The `Dio` instance is supercharged with interceptors for:
    - `LoadingInterceptor`: Shows/hides a global loading indicator.
    - `LoggingInterceptor`: Provides detailed network logs in debug mode.
    - `AuthInterceptor`: Automatically adds the authentication token to requests.
    - `ErrorInterceptor`: Provides a hook for global error handling (e.g., token refresh).

### Widget Library

A collection of powerful, reusable widgets is located in `lib/core/widgets`:

- **`AppButton`:** A versatile button with `filled`, `outlined`, and `text` styles, plus icon support.
- **`AppTextField`:** A consistent, theme-able text input field.
- **`AppCard`:** A beautiful container for grouping content.
- **`AppCircularProgressIndicator` & `AppErrorWidget`:** Standardized widgets for displaying loading and error states for any state management solution.

This template is designed to provide a powerful and flexible foundation so you can build amazing applications faster. Happy coding!
