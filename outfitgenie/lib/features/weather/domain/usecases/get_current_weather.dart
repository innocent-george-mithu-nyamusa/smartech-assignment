import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

/// Use case: Get current weather
class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  /// Get weather by coordinates
  Future<Either<Failure, Weather>> byCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    return await repository.getWeatherByCoordinates(
      latitude: latitude,
      longitude: longitude,
    );
  }

  /// Get weather by city name
  Future<Either<Failure, Weather>> byCity(String cityName) async {
    return await repository.getWeatherByCity(cityName);
  }

  /// Get weather for current location
  Future<Either<Failure, Weather>> forCurrentLocation() async {
    final locationResult = await repository.getCurrentLocation();

    return await locationResult.fold(
      (failure) => Left(failure),
      (location) => repository.getWeatherByCoordinates(
        latitude: location.latitude,
        longitude: location.longitude,
      ),
    );
  }
}
