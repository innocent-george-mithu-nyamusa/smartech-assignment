import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/outfit_recommendation.dart';
import '../repositories/recommendation_repository.dart';

/// Use case: Save favorite recommendation
class SaveFavorite {
  final RecommendationRepository repository;

  SaveFavorite(this.repository);

  Future<Either<Failure, void>> call(OutfitRecommendation recommendation) async {
    return await repository.saveFavorite(recommendation);
  }
}

/// Use case: Get favorite recommendations
class GetFavorites {
  final RecommendationRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, List<OutfitRecommendation>>> call() async {
    return await repository.getFavorites();
  }
}

/// Use case: Remove favorite
class RemoveFavorite {
  final RecommendationRepository repository;

  RemoveFavorite(this.repository);

  Future<Either<Failure, void>> call(String recommendationId) async {
    return await repository.removeFavorite(recommendationId);
  }
}
