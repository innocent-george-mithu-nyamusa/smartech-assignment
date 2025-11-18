import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/outfit_recommendation.dart';
import '../entities/recommendation_request.dart';
import '../repositories/recommendation_repository.dart';

/// Use case: Get outfit recommendations
class GetRecommendations {
  final RecommendationRepository repository;

  GetRecommendations(this.repository);

  Future<Either<Failure, List<OutfitRecommendation>>> call(
    RecommendationRequest request,
  ) async {
    return await repository.getRecommendations(request);
  }
}
