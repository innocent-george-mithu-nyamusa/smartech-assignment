import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/location_datasource.dart';
import '../datasources/weather_local_datasource.dart';
import '../datasources/weather_remote_datasource.dart';

/// Weather repository implementation
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final LocationDataSource locationDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.locationDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherModel = await remoteDataSource.getWeatherByCoordinates(
          latitude: latitude,
          longitude: longitude,
        );

        // Cache the weather data
        await localDataSource.cacheWeather(weatherModel);

        return Right(weatherModel.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } catch (e) {
        return Left(UnexpectedFailure(e.toString()));
      }
    } else {
      // Try to get cached weather if offline
      try {
        if (await localDataSource.isCacheValid()) {
          final cachedWeather = await localDataSource.getCachedWeather();
          return Right(cachedWeather.toEntity());
        } else {
          return const Left(
            NetworkFailure('No internet connection and cache expired'),
          );
        }
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Weather>> getWeatherByCity(String cityName) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherModel = await remoteDataSource.getWeatherByCity(cityName);

        // Cache the weather data
        await localDataSource.cacheWeather(weatherModel);

        return Right(weatherModel.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } catch (e) {
        return Left(UnexpectedFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Weather>> getCachedWeather() async {
    try {
      final cachedWeather = await localDataSource.getCachedWeather();
      return Right(cachedWeather.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Location>> getCurrentLocation() async {
    try {
      final locationModel = await locationDataSource.getCurrentLocation();
      return Right(locationModel.toEntity());
    } on ServerException catch (e) {
      return Left(PermissionFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
