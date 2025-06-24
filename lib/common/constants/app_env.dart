import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppEnv {
  const AppEnv._();

  static Future<void> init() async {
    const env = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
    await dotenv.load(fileName: ".env.$env");
  }

  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  static String get appName => dotenv.env['APP_NAME'] ?? '';

  static String get packageName => dotenv.env['PACKAGE_NAME'] ?? '';

  static bool get debugMode =>
      bool.tryParse(dotenv.env['DEBUG_MODE'] ?? 'false') ?? false;
}
