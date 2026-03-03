## 1.0.3

* Added an example project in the `example/` directory.
* Improved API documentation with standard Dartdoc comments for core classes.
* Updated `pubspec.yaml` for better metadata and pub.dev compatibility.
* Updated GitHub repository and issue tracker URLs.

## 1.0.2

* Updated documentation and project metadata.
* Fixed minor internal issues for better stability.

## 1.0.1

* Added missing barrel file exports.
* Refactored ThemeService for better persistence.

## 1.0.0

* Initial Release: A production-ready Flutter starter architecture.
* Networking: Integrated Dio with centralized error handling (`BaseRepository`) and proactive connectivity checks (`ConnectivityInterceptor`).
* State Management: Un-opinionated design allowing for any state management library.
* Theme: Lightweight `ThemeService` with built-in persistence (Light/Dark mode).
* Navigation: Stable, package-less routing using Flutter's native Navigator API.
* UI Kit: A suite of enhanced, reusable core widgets (`AppButton`, `AppTextField`, `AppCard`, etc.).
* Utilities: Centralized form validation logic and service locator (`get_it`) setup.
* Documentation: Comprehensive README with installation and quick-start guides.
* Structure: Added barrel file (`template_project.dart`) for easy imports.
