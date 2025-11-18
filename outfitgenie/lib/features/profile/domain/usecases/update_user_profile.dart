import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

/// Use case: Update user profile
class UpdateUserProfile {
  final ProfileRepository repository;

  UpdateUserProfile(this.repository);

  Future<Either<Failure, UserProfile>> call(UserProfile profile) async {
    return await repository.updateUserProfile(profile);
  }
}
