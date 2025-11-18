import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/outfit_recommendation.dart';
import '../../domain/entities/recommendation_request.dart';
import '../../domain/repositories/recommendation_repository.dart';
import '../datasources/recommendation_local_datasource.dart';
import '../datasources/recommendation_remote_datasource.dart';
import '../models/outfit_recommendation_model.dart';
import '../models/recommendation_request_model.dart';

/// Recommendation repository implementation
class RecommendationRepositoryImpl implements RecommendationRepository {
  final RecommendationRemoteDataSource remoteDataSource;
  final RecommendationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RecommendationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<OutfitRecommendation>>> getRecommendations(
    RecommendationRequest request,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final requestModel = RecommendationRequestModel.fromEntity(request);
        final recommendations = await remoteDataSource.getRecommendations(requestModel);

        // Cache the recommendations
        await localDataSource.cacheRecommendations(recommendations);

        return Right(recommendations.map((r) => r.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } catch (e) {
        return Left(UnexpectedFailure(e.toString()));
      }
    } else {
      // Try to return cached recommendations if offline
      try {
        final cachedRecommendations = await localDataSource.getCachedRecommendations();
        return Right(cachedRecommendations.map((r) => r.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<OutfitRecommendation>>> getRecommendationsByOccasion({
    required String occasion,
    String? style,
    List<String>? colors,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final recommendations = await remoteDataSource.getRecommendationsByOccasion(
          occasion: occasion,
          style: style,
          colors: colors,
        );

        return Right(recommendations.map((r) => r.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } catch (e) {
        return Left(UnexpectedFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<OutfitRecommendation>>> getCachedRecommendations() async {
    try {
      final cachedRecommendations = await localDataSource.getCachedRecommendations();
      return Right(cachedRecommendations.map((r) => r.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveFavorite(OutfitRecommendation recommendation) async {
    try {
      final model = OutfitRecommendationModel.fromEntity(recommendation);
      await localDataSource.saveFavorite(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OutfitRecommendation>>> getFavorites() async {
    try {
      final favorites = await localDataSource.getFavorites();
      return Right(favorites.map((r) => r.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String recommendationId) async {
    try {
      await localDataSource.removeFavorite(recommendationId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
