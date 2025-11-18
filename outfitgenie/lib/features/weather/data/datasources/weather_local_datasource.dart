import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/weather_model.dart';

/// Weather local data source interface
abstract class WeatherLocalDataSource {
  /// Get cached weather
  Future<WeatherModel> getCachedWeather();

  /// Cache weather
  Future<void> cacheWeather(WeatherModel weather);

  /// Check if weather cache is valid
  Future<bool> isCacheValid();
}

/// Weather local data source implementation
class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cachedWeatherKey = 'cached_weather';
  static const String cacheTimestampKey = 'weather_cache_timestamp';
  static const Duration cacheDuration = Duration(minutes: 30);

  WeatherLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<WeatherModel> getCachedWeather() async {
    try {
      final jsonString = sharedPreferences.getString(cachedWeatherKey);

      if (jsonString == null) {
        throw const CacheException('No cached weather found');
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return WeatherModel.fromJson(json);
    } catch (e) {
      throw CacheException('Failed to get cached weather: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    try {
      final jsonString = jsonEncode(weather.toJson());
      await sharedPreferences.setString(cachedWeatherKey, jsonString);
      await sharedPreferences.setInt(
        cacheTimestampKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      throw CacheException('Failed to cache weather: ${e.toString()}');
    }
  }

  @override
  Future<bool> isCacheValid() async {
    final timestamp = sharedPreferences.getInt(cacheTimestampKey);

    if (timestamp == null) return false;

    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();

    return now.difference(cacheTime) < cacheDuration;
  }
}
