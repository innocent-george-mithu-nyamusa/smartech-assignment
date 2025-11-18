import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration
class EnvConfig {
  EnvConfig._();

  /// Load environment variables
  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }

  /// Get backend API URL
  static String get backendApiUrl {
    return dotenv.env['BACKEND_API_URL'] ?? 'http://localhost:8000';
  }

  /// Get weather API key
  static String get weatherApiKey {
    return dotenv.env['WEATHER_API_KEY'] ?? '';
  }

  /// Get environment (dev, staging, prod)
  static String get environment {
    return dotenv.env['ENVIRONMENT'] ?? 'development';
  }

  /// Check if in development mode
  static bool get isDevelopment {
    return environment == 'development';
  }

  /// Check if in production mode
  static bool get isProduction {
    return environment == 'production';
  }
}
