enum Environment { dev, prod }

class AppConfig {
  final String baseUrl;
  final Environment environment;

  AppConfig({required this.baseUrl, required this.environment});

  static AppConfig dev() {
    return AppConfig(
      baseUrl: 'https://reqres.in/api/',
      environment: Environment.dev,
    );
  }

  static AppConfig prod() {
    return AppConfig(
      baseUrl: 'https://fakestoreapi.com/', // Replace with your prod URL
      environment: Environment.prod,
    );
  }
}
