import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_recommendations.dart' as usecases;
import '../../domain/usecases/get_recommendations_by_occasion.dart' as usecases;
import '../../domain/usecases/manage_favorites.dart' as usecases;
import 'recommendation_event.dart';
import 'recommendation_state.dart';

/// Recommendation BLoC
class RecommendationBloc extends Bloc<RecommendationEvent, RecommendationState> {
  final usecases.GetRecommendations getRecommendations;
  final usecases.GetRecommendationsByOccasion getRecommendationsByOccasion;
  final usecases.SaveFavorite saveFavoriteUseCase;
  final usecases.GetFavorites getFavoritesUseCase;
  final usecases.RemoveFavorite removeFavoriteUseCase;

  // Keep track of loaded recommendations for favorites
  List<dynamic> _currentRecommendations = [];

  RecommendationBloc({
    required this.getRecommendations,
    required this.getRecommendationsByOccasion,
    required this.saveFavoriteUseCase,
    required this.getFavoritesUseCase,
    required this.removeFavoriteUseCase,
  }) : super(const RecommendationInitial()) {
    on<GetRecommendations>(_onGetRecommendations);
    on<GetRecommendationsByOccasion>(_onGetRecommendationsByOccasion);
    on<LoadFavorites>(_onLoadFavorites);
    on<SaveFavorite>(_onSaveFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
  }

  Future<void> _onGetRecommendations(
    GetRecommendations event,
    Emitter<RecommendationState> emit,
  ) async {
    emit(const RecommendationLoading());

    final result = await getRecommendations(event.request);

    result.fold(
      (failure) => emit(RecommendationError(failure.message)),
      (recommendations) {
        _currentRecommendations = recommendations;
        if (recommendations.isEmpty) {
          emit(const RecommendationsEmpty());
        } else {
          emit(RecommendationsLoaded(recommendations));
        }
      },
    );
  }

  Future<void> _onGetRecommendationsByOccasion(
    GetRecommendationsByOccasion event,
    Emitter<RecommendationState> emit,
  ) async {
    emit(const RecommendationLoading());

    final result = await getRecommendationsByOccasion(
      occasion: event.occasion,
      style: event.style,
      colors: event.colors,
    );

    result.fold(
      (failure) => emit(RecommendationError(failure.message)),
      (recommendations) {
        _currentRecommendations = recommendations;
        if (recommendations.isEmpty) {
          emit(const RecommendationsEmpty());
        } else {
          emit(RecommendationsLoaded(recommendations));
        }
      },
    );
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<RecommendationState> emit,
  ) async {
    emit(const RecommendationLoading());

    final result = await getFavoritesUseCase();

    result.fold(
      (failure) => emit(RecommendationError(failure.message)),
      (favorites) => emit(FavoritesLoaded(favorites)),
    );
  }

  Future<void> _onSaveFavorite(
    SaveFavorite event,
    Emitter<RecommendationState> emit,
  ) async {
    // Find the recommendation from current list
    final recommendation = _currentRecommendations
        .firstWhere((r) => r.id == event.recommendationId);

    final result = await saveFavoriteUseCase(recommendation);

    result.fold(
      (failure) => emit(RecommendationError(failure.message)),
      (_) => emit(const FavoriteSaved()),
    );
  }

  Future<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<RecommendationState> emit,
  ) async {
    final result = await removeFavoriteUseCase(event.recommendationId);

    result.fold(
      (failure) => emit(RecommendationError(failure.message)),
      (_) => emit(const FavoriteRemoved()),
    );
  }
}
