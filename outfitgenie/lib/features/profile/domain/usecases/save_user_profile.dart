import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

/// Use case: Save user profile
class SaveUserProfile {
  final ProfileRepository repository;

  SaveUserProfile(this.repository);

  Future<Either<Failure, void>> call(UserProfile profile) async {
    return await repository.saveUserProfile(profile);
  }
}
