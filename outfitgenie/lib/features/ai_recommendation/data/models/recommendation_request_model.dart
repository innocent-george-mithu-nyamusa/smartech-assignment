import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/recommendation_request.dart';

part 'recommendation_request_model.g.dart';

/// User preferences for API
@JsonSerializable()
class UserPreferencesDto {
  final List<String> styles;
  final List<String> colors;
  @JsonKey(name: 'avoid_colors')
  final List<String>? avoidColors;

  const UserPreferencesDto({
    required this.styles,
    required this.colors,
    this.avoidColors,
  });

  factory UserPreferencesDto.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferencesDtoToJson(this);
}

/// Weather data for API
@JsonSerializable()
class WeatherDataDto {
  final double temperature;
  final String condition;
  final int humidity;
  @JsonKey(name: 'wind_speed')
  final double windSpeed;

  const WeatherDataDto({
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherDataDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataDtoToJson(this);
}

/// Recommendation request data model
@JsonSerializable()
class RecommendationRequestModel {
  @JsonKey(name: 'user_preferences')
  final UserPreferencesDto userPreferences;
  final WeatherDataDto weather;
  final String occasion;
  @JsonKey(name: 'additional_notes')
  final String? additionalNotes;

  const RecommendationRequestModel({
    required this.userPreferences,
    required this.weather,
    required this.occasion,
    this.additionalNotes,
  });

  /// From entity
  factory RecommendationRequestModel.fromEntity(RecommendationRequest request) {
    return RecommendationRequestModel(
      userPreferences: UserPreferencesDto(
        styles: request.userProfile.preferredStyles,
        colors: request.userProfile.preferredColors,
        avoidColors: request.userProfile.avoidColors,
      ),
      weather: WeatherDataDto(
        temperature: request.weather.temperature,
        condition: request.weather.condition,
        humidity: request.weather.humidity,
        windSpeed: request.weather.windSpeed,
      ),
      occasion: request.occasion,
      additionalNotes: request.additionalNotes,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() => _$RecommendationRequestModelToJson(this);

  /// From JSON
  factory RecommendationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationRequestModelFromJson(json);
}
