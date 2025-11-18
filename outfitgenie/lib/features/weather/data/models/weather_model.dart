import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/weather.dart';

part 'weather_model.g.dart';

/// Weather data model
@JsonSerializable()
class WeatherModel extends Weather {
  const WeatherModel({
    required super.location,
    required super.temperature,
    required super.feelsLike,
    required super.condition,
    required super.description,
    required super.humidity,
    required super.windSpeed,
    required super.icon,
    required super.timestamp,
  });

  /// From JSON (OpenWeatherMap API format)
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['name'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      condition: json['weather'][0]['main'] ?? '',
      description: json['weather'][0]['description'] ?? '',
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      icon: json['weather'][0]['icon'] ?? '',
      timestamp: DateTime.now(),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  /// To entity
  Weather toEntity() {
    return Weather(
      location: location,
      temperature: temperature,
      feelsLike: feelsLike,
      condition: condition,
      description: description,
      humidity: humidity,
      windSpeed: windSpeed,
      icon: icon,
      timestamp: timestamp,
    );
  }

  /// From entity
  factory WeatherModel.fromEntity(Weather weather) {
    return WeatherModel(
      location: weather.location,
      temperature: weather.temperature,
      feelsLike: weather.feelsLike,
      condition: weather.condition,
      description: weather.description,
      humidity: weather.humidity,
      windSpeed: weather.windSpeed,
      icon: weather.icon,
      timestamp: weather.timestamp,
    );
  }
}
