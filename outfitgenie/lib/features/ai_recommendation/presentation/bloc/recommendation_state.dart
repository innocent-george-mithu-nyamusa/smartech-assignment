import 'package:equatable/equatable.dart';

import '../../domain/entities/outfit_recommendation.dart';

/// Recommendation states
abstract class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class RecommendationInitial extends RecommendationState {
  const RecommendationInitial();
}

/// Loading state
class RecommendationLoading extends RecommendationState {
  const RecommendationLoading();
}

/// Recommendations loaded successfully
class RecommendationsLoaded extends RecommendationState {
  final List<OutfitRecommendation> recommendations;
  final bool isCached;

  const RecommendationsLoaded(this.recommendations, {this.isCached = false});

  @override
  List<Object?> get props => [recommendations, isCached];
}

/// Favorites loaded
class FavoritesLoaded extends RecommendationState {
  final List<OutfitRecommendation> favorites;

  const FavoritesLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

/// Favorite saved
class FavoriteSaved extends RecommendationState {
  const FavoriteSaved();
}

/// Favorite removed
class FavoriteRemoved extends RecommendationState {
  const FavoriteRemoved();
}

/// Recommendation error
class RecommendationError extends RecommendationState {
  final String message;

  const RecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Empty state (no recommendations)
class RecommendationsEmpty extends RecommendationState {
  const RecommendationsEmpty();
}
