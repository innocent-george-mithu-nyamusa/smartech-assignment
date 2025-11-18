import 'package:equatable/equatable.dart';

/// Weather entity
class Weather extends Equatable {
  final String location;
  final double temperature;
  final double feelsLike;
  final String condition;
  final String description;
  final int humidity;
  final double windSpeed;
  final String icon;
  final DateTime timestamp;

  const Weather({
    required this.location,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
    required this.timestamp,
  });

  /// Get weather category for outfit recommendations
  String get weatherCategory {
    if (temperature > 30) return 'Hot';
    if (temperature > 25) return 'Warm';
    if (temperature > 15) return 'Mild';
    if (temperature > 5) return 'Cool';
    return 'Cold';
  }

  /// Check if it's rainy
  bool get isRainy {
    return condition.toLowerCase().contains('rain') ||
        description.toLowerCase().contains('rain');
  }

  /// Check if it's sunny
  bool get isSunny {
    return condition.toLowerCase().contains('clear') ||
        condition.toLowerCase().contains('sun');
  }

  /// Check if it's windy
  bool get isWindy {
    return windSpeed > 20; // km/h
  }

  @override
  List<Object?> get props => [
        location,
        temperature,
        feelsLike,
        condition,
        description,
        humidity,
        windSpeed,
        icon,
        timestamp,
      ];
}
