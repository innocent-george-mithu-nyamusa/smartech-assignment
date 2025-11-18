import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/outfit_recommendation.dart';
import '../repositories/recommendation_repository.dart';

/// Use case: Get recommendations by occasion
class GetRecommendationsByOccasion {
  final RecommendationRepository repository;

  GetRecommendationsByOccasion(this.repository);

  Future<Either<Failure, List<OutfitRecommendation>>> call({
    required String occasion,
    String? style,
    List<String>? colors,
  }) async {
    return await repository.getRecommendationsByOccasion(
      occasion: occasion,
      style: style,
      colors: colors,
    );
  }
}
