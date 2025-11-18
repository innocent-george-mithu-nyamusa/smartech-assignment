import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/location.dart';
import '../entities/weather.dart';

/// Weather repository interface
abstract class WeatherRepository {
  /// Get current weather by coordinates
  Future<Either<Failure, Weather>> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
  });

  /// Get current weather by city name
  Future<Either<Failure, Weather>> getWeatherByCity(String cityName);

  /// Get cached weather
  Future<Either<Failure, Weather>> getCachedWeather();

  /// Get current location
  Future<Either<Failure, Location>> getCurrentLocation();
}
