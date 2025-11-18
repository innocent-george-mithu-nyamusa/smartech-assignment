import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../models/user_profile_model.dart';

/// Profile repository implementation
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      final profileModel = await localDataSource.getCachedUserProfile();
      return Right(profileModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserProfile(UserProfile profile) async {
    try {
      final profileModel = UserProfileModel.fromEntity(profile);
      await localDataSource.cacheUserProfile(profileModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile(
    UserProfile profile,
  ) async {
    try {
      // Update the profile with new timestamp
      final updatedProfile = profile.copyWith(
        updatedAt: DateTime.now(),
      );
      final profileModel = UserProfileModel.fromEntity(updatedProfile);
      await localDataSource.cacheUserProfile(profileModel);
      return Right(updatedProfile);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserProfile() async {
    try {
      await localDataSource.deleteCachedProfile();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> hasProfile() async {
    try {
      final exists = await localDataSource.hasProfile();
      return Right(exists);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
