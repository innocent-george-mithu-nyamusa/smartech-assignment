import 'package:equatable/equatable.dart';

import '../../domain/entities/weather.dart';

/// Weather states
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

/// Loading state
class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

/// Weather loaded successfully
class WeatherLoaded extends WeatherState {
  final Weather weather;
  final bool isCached;

  const WeatherLoaded(this.weather, {this.isCached = false});

  @override
  List<Object?> get props => [weather, isCached];
}

/// Weather error
class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Location permission denied
class WeatherLocationPermissionDenied extends WeatherState {
  const WeatherLocationPermissionDenied();
}

/// Location services disabled
class WeatherLocationServicesDisabled extends WeatherState {
  const WeatherLocationServicesDisabled();
}
