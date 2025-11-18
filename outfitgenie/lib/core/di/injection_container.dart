import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/profile/data/datasources/profile_local_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_user_profile.dart';
import '../../features/profile/domain/usecases/save_user_profile.dart' as profile_usecases;
import '../../features/profile/domain/usecases/update_user_profile.dart' as profile_usecases;
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/weather/data/datasources/location_datasource.dart';
import '../../features/weather/data/datasources/weather_local_datasource.dart';
import '../../features/weather/data/datasources/weather_remote_datasource.dart';
import '../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../features/weather/domain/repositories/weather_repository.dart';
import '../../features/weather/domain/usecases/get_current_location.dart';
import '../../features/weather/domain/usecases/get_current_weather.dart';
import '../../features/weather/presentation/bloc/weather_bloc.dart';
import '../../features/ai_recommendation/data/datasources/recommendation_local_datasource.dart';
import '../../features/ai_recommendation/data/datasources/recommendation_remote_datasource.dart';
import '../../features/ai_recommendation/data/repositories/recommendation_repository_impl.dart';
import '../../features/ai_recommendation/domain/repositories/recommendation_repository.dart';
import '../../features/ai_recommendation/domain/usecases/get_recommendations.dart' as recommendation_usecases;
import '../../features/ai_recommendation/domain/usecases/get_recommendations_by_occasion.dart' as recommendation_usecases;
import '../../features/ai_recommendation/domain/usecases/manage_favorites.dart' as recommendation_usecases;
import '../../features/ai_recommendation/presentation/bloc/recommendation_bloc.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

/// Initialize dependency injection
Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  // Core
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<Dio>(() => getIt<DioClient>().dio);

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );

  // Features
  _initProfileDependencies();
  _initWeatherDependencies();
  _initAIRecommendationDependencies();

  // Outfit Suggestion
  // _initOutfitSuggestionDependencies();

  // Shopping
  // _initShoppingDependencies();
}

/// Initialize Profile dependencies
void _initProfileDependencies() {
  // Data sources
  getIt.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      localDataSource: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetUserProfile(getIt()));
  getIt.registerLazySingleton(() => profile_usecases.SaveUserProfile(getIt()));
  getIt.registerLazySingleton(() => profile_usecases.UpdateUserProfile(getIt()));

  // BLoC
  getIt.registerFactory(
    () => ProfileBloc(
      getUserProfile: getIt(),
      saveUserProfile: getIt(),
      updateUserProfile: getIt(),
    ),
  );
}

/// Initialize Weather dependencies
void _initWeatherDependencies() {
  // Data sources
  getIt.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      dio: getIt(),
      apiKey: dotenv.env['WEATHER_API_KEY'] ?? '',
    ),
  );

  getIt.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<LocationDataSource>(
    () => LocationDataSourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      locationDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetCurrentWeather(getIt()));
  getIt.registerLazySingleton(() => GetCurrentLocation(getIt()));

  // BLoC
  getIt.registerFactory(
    () => WeatherBloc(
      getCurrentWeather: getIt(),
      getCurrentLocation: getIt(),
    ),
  );
}

/// Initialize AI Recommendation dependencies
void _initAIRecommendationDependencies() {
  // Data sources
  getIt.registerLazySingleton<RecommendationRemoteDataSource>(
    () => RecommendationRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<RecommendationLocalDataSource>(
    () => RecommendationLocalDataSourceImpl(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<RecommendationRepository>(
    () => RecommendationRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => recommendation_usecases.GetRecommendations(getIt()));
  getIt.registerLazySingleton(() => recommendation_usecases.GetRecommendationsByOccasion(getIt()));
  getIt.registerLazySingleton(() => recommendation_usecases.SaveFavorite(getIt()));
  getIt.registerLazySingleton(() => recommendation_usecases.GetFavorites(getIt()));
  getIt.registerLazySingleton(() => recommendation_usecases.RemoveFavorite(getIt()));

  // BLoC
  getIt.registerFactory(
    () => RecommendationBloc(
      getRecommendations: getIt(),
      getRecommendationsByOccasion: getIt(),
      saveFavoriteUseCase: getIt(),
      getFavoritesUseCase: getIt(),
      removeFavoriteUseCase: getIt(),
    ),
  );
}

// Feature-specific dependency initialization functions will be added here
// Example:
// void _initProfileDependencies() {
//   // Data sources
//   getIt.registerLazySingleton<ProfileLocalDataSource>(
//     () => ProfileLocalDataSourceImpl(getIt()),
//   );
//
//   getIt.registerLazySingleton<ProfileRemoteDataSource>(
//     () => ProfileRemoteDataSourceImpl(getIt()),
//   );
//
//   // Repository
//   getIt.registerLazySingleton<ProfileRepository>(
//     () => ProfileRepositoryImpl(
//       localDataSource: getIt(),
//       remoteDataSource: getIt(),
//       networkInfo: getIt(),
//     ),
//   );
//
//   // Use cases
//   getIt.registerLazySingleton(() => GetUserProfile(getIt()));
//   getIt.registerLazySingleton(() => SaveUserProfile(getIt()));
//
//   // BLoC
//   getIt.registerFactory(
//     () => ProfileBloc(
//       getUserProfile: getIt(),
//       saveUserProfile: getIt(),
//     ),
//   );
// }
