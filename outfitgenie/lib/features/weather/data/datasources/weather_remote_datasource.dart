import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/weather_model.dart';

/// Weather remote data source interface
abstract class WeatherRemoteDataSource {
  /// Get weather by coordinates
  Future<WeatherModel> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
  });

  /// Get weather by city name
  Future<WeatherModel> getWeatherByCity(String cityName);
}

/// Weather remote data source implementation (OpenWeatherMap API)
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;
  final String apiKey;

  WeatherRemoteDataSourceImpl({
    required this.dio,
    required this.apiKey,
  });

  @override
  Future<WeatherModel> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'appid': apiKey,
          'units': 'metric', // Celsius
        },
        options: Options(
          sendTimeout: ApiConstants.sendTimeout,
          receiveTimeout: ApiConstants.receiveTimeout,
        ),
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw ServerException(
          'Failed to get weather data',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const NetworkException('Connection timeout');
      } else if (e.response?.statusCode == 401) {
        throw const ServerException('Invalid API key', '401');
      } else {
        throw ServerException(
          'Failed to get weather data: ${e.message}',
          e.response?.statusCode.toString(),
        );
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    try {
      final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'q': cityName,
          'appid': apiKey,
          'units': 'metric',
        },
        options: Options(
          sendTimeout: ApiConstants.sendTimeout,
          receiveTimeout: ApiConstants.receiveTimeout,
        ),
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw ServerException(
          'Failed to get weather data',
          response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const NetworkException('Connection timeout');
      } else if (e.response?.statusCode == 404) {
        throw const ServerException('City not found', '404');
      } else {
        throw ServerException(
          'Failed to get weather data: ${e.message}',
          e.response?.statusCode.toString(),
        );
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}
