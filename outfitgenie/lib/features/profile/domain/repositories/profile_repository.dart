import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_profile.dart';

/// Profile repository interface
abstract class ProfileRepository {
  /// Get user profile
  Future<Either<Failure, UserProfile>> getUserProfile();

  /// Save user profile
  Future<Either<Failure, void>> saveUserProfile(UserProfile profile);

  /// Update user profile
  Future<Either<Failure, UserProfile>> updateUserProfile(UserProfile profile);

  /// Delete user profile
  Future<Either<Failure, void>> deleteUserProfile();

  /// Check if profile exists
  Future<Either<Failure, bool>> hasProfile();
}
