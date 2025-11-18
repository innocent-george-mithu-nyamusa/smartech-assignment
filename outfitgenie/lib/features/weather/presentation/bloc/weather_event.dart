import 'package:equatable/equatable.dart';

/// Weather events
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

/// Get weather for current location
class GetWeatherForCurrentLocation extends WeatherEvent {
  const GetWeatherForCurrentLocation();
}

/// Get weather by coordinates
class GetWeatherByCoordinates extends WeatherEvent {
  final double latitude;
  final double longitude;

  const GetWeatherByCoordinates({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

/// Get weather by city name
class GetWeatherByCity extends WeatherEvent {
  final String cityName;

  const GetWeatherByCity(this.cityName);

  @override
  List<Object?> get props => [cityName];
}

/// Load cached weather
class LoadCachedWeather extends WeatherEvent {
  const LoadCachedWeather();
}

/// Refresh weather
class RefreshWeather extends WeatherEvent {
  const RefreshWeather();
}
