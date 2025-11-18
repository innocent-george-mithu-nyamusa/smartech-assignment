/// API Constants for the application
class ApiConstants {
  // Prevent instantiation
  ApiConstants._();

  /// API Base URLs
  static const String backendBaseUrl = String.fromEnvironment(
    'BACKEND_API_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );

  /// API Endpoints
  static const String apiVersion = '/api/v1';

  // Recommendation endpoints
  static const String recommendationsEndpoint = '$apiVersion/recommendations';
  static const String recommendByOccasionEndpoint = '$apiVersion/recommendations/occasion';

  // Weather endpoints
  static const String weatherEndpoint = '$apiVersion/weather';

  // Profile endpoints
  static const String profileEndpoint = '$apiVersion/profile';
  static const String profilePreferencesEndpoint = '$apiVersion/profile/preferences';

  // Shopping endpoints (optional)
  static const String shoppingEndpoint = '$apiVersion/shopping';
  static const String shoppingSearchEndpoint = '$apiVersion/shopping/search';

  /// API Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  /// API Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
}
