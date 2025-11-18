// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferencesDto _$UserPreferencesDtoFromJson(Map<String, dynamic> json) =>
    UserPreferencesDto(
      styles:
          (json['styles'] as List<dynamic>).map((e) => e as String).toList(),
      colors:
          (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
      avoidColors: (json['avoid_colors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserPreferencesDtoToJson(UserPreferencesDto instance) =>
    <String, dynamic>{
      'styles': instance.styles,
      'colors': instance.colors,
      'avoid_colors': instance.avoidColors,
    };

WeatherDataDto _$WeatherDataDtoFromJson(Map<String, dynamic> json) =>
    WeatherDataDto(
      temperature: (json['temperature'] as num).toDouble(),
      condition: json['condition'] as String,
      humidity: (json['humidity'] as num).toInt(),
      windSpeed: (json['wind_speed'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherDataDtoToJson(WeatherDataDto instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'condition': instance.condition,
      'humidity': instance.humidity,
      'wind_speed': instance.windSpeed,
    };

RecommendationRequestModel _$RecommendationRequestModelFromJson(
        Map<String, dynamic> json) =>
    RecommendationRequestModel(
      userPreferences: UserPreferencesDto.fromJson(
          json['user_preferences'] as Map<String, dynamic>),
      weather: WeatherDataDto.fromJson(json['weather'] as Map<String, dynamic>),
      occasion: json['occasion'] as String,
      additionalNotes: json['additional_notes'] as String?,
    );

Map<String, dynamic> _$RecommendationRequestModelToJson(
        RecommendationRequestModel instance) =>
    <String, dynamic>{
      'user_preferences': instance.userPreferences,
      'weather': instance.weather,
      'occasion': instance.occasion,
      'additional_notes': instance.additionalNotes,
    };
