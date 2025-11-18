// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      location: json['location'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      feelsLike: (json['feelsLike'] as num).toDouble(),
      condition: json['condition'] as String,
      description: json['description'] as String,
      humidity: (json['humidity'] as num).toInt(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      icon: json['icon'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'temperature': instance.temperature,
      'feelsLike': instance.feelsLike,
      'condition': instance.condition,
      'description': instance.description,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
      'icon': instance.icon,
      'timestamp': instance.timestamp.toIso8601String(),
    };
