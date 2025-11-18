import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/location.dart';
import '../repositories/weather_repository.dart';

/// Use case: Get current location
class GetCurrentLocation {
  final WeatherRepository repository;

  GetCurrentLocation(this.repository);

  Future<Either<Failure, Location>> call() async {
    return await repository.getCurrentLocation();
  }
}
