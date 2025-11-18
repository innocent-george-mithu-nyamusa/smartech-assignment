/// Base exception class
class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Server exception (API errors)
class ServerException extends AppException {
  const ServerException([String message = 'Server error', String? code]) : super(message, code);
}

/// Cache exception (local storage errors)
class CacheException extends AppException {
  const CacheException([String message = 'Cache error', String? code]) : super(message, code);
}

/// Network exception (no internet)
class NetworkException extends AppException {
  const NetworkException([String message = 'Network error', String? code]) : super(message, code);
}

/// Validation exception (invalid data)
class ValidationException extends AppException {
  const ValidationException([String message = 'Validation error', String? code]) : super(message, code);
}
