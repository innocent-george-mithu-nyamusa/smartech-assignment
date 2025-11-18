import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/outfit_recommendation.dart';
import '../entities/recommendation_request.dart';

/// Recommendation repository interface
abstract class RecommendationRepository {
  /// Get outfit recommendations
  Future<Either<Failure, List<OutfitRecommendation>>> getRecommendations(
    RecommendationRequest request,
  );

  /// Get recommendations by occasion
  Future<Either<Failure, List<OutfitRecommendation>>> getRecommendationsByOccasion({
    required String occasion,
    String? style,
    List<String>? colors,
  });

  /// Get cached recommendations
  Future<Either<Failure, List<OutfitRecommendation>>> getCachedRecommendations();

  /// Save favorite recommendation
  Future<Either<Failure, void>> saveFavorite(OutfitRecommendation recommendation);

  /// Get favorite recommendations
  Future<Either<Failure, List<OutfitRecommendation>>> getFavorites();

  /// Remove favorite
  Future<Either<Failure, void>> removeFavorite(String recommendationId);
}
