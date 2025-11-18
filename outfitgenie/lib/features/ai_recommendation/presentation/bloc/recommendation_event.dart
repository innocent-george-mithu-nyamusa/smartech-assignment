import 'package:equatable/equatable.dart';

import '../../domain/entities/recommendation_request.dart';

/// Recommendation events
abstract class RecommendationEvent extends Equatable {
  const RecommendationEvent();

  @override
  List<Object?> get props => [];
}

/// Get recommendations
class GetRecommendations extends RecommendationEvent {
  final RecommendationRequest request;

  const GetRecommendations(this.request);

  @override
  List<Object?> get props => [request];
}

/// Get recommendations by occasion
class GetRecommendationsByOccasion extends RecommendationEvent {
  final String occasion;
  final String? style;
  final List<String>? colors;

  const GetRecommendationsByOccasion({
    required this.occasion,
    this.style,
    this.colors,
  });

  @override
  List<Object?> get props => [occasion, style, colors];
}

/// Load cached recommendations
class LoadCachedRecommendations extends RecommendationEvent {
  const LoadCachedRecommendations();
}

/// Load favorites
class LoadFavorites extends RecommendationEvent {
  const LoadFavorites();
}

/// Save favorite
class SaveFavorite extends RecommendationEvent {
  final String recommendationId;

  const SaveFavorite(this.recommendationId);

  @override
  List<Object?> get props => [recommendationId];
}

/// Remove favorite
class RemoveFavorite extends RecommendationEvent {
  final String recommendationId;

  const RemoveFavorite(this.recommendationId);

  @override
  List<Object?> get props => [recommendationId];
}
