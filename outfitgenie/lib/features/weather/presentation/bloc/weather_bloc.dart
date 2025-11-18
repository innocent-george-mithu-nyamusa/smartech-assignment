import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/get_current_weather.dart';
import 'weather_event.dart';
import 'weather_state.dart';

/// Weather BLoC
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final GetCurrentLocation getCurrentLocation;

  WeatherBloc({
    required this.getCurrentWeather,
    required this.getCurrentLocation,
  }) : super(const WeatherInitial()) {
    on<GetWeatherForCurrentLocation>(_onGetWeatherForCurrentLocation);
    on<GetWeatherByCoordinates>(_onGetWeatherByCoordinates);
    on<GetWeatherByCity>(_onGetWeatherByCity);
    on<RefreshWeather>(_onRefreshWeather);
  }

  Future<void> _onGetWeatherForCurrentLocation(
    GetWeatherForCurrentLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());

    final result = await getCurrentWeather.forCurrentLocation();

    result.fold(
      (failure) {
        if (failure.message.contains('permission')) {
          emit(const WeatherLocationPermissionDenied());
        } else if (failure.message.contains('disabled')) {
          emit(const WeatherLocationServicesDisabled());
        } else {
          emit(WeatherError(failure.message));
        }
      },
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  Future<void> _onGetWeatherByCoordinates(
    GetWeatherByCoordinates event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());

    final result = await getCurrentWeather.byCoordinates(
      latitude: event.latitude,
      longitude: event.longitude,
    );

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  Future<void> _onGetWeatherByCity(
    GetWeatherByCity event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());

    final result = await getCurrentWeather.byCity(event.cityName);

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  Future<void> _onRefreshWeather(
    RefreshWeather event,
    Emitter<WeatherState> emit,
  ) async {
    // Get current location and fetch new weather
    add(const GetWeatherForCurrentLocation());
  }
}
