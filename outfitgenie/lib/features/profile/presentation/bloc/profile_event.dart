import 'package:equatable/equatable.dart';

import '../../domain/entities/user_profile.dart';

/// Profile events
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Load user profile
class LoadUserProfile extends ProfileEvent {
  const LoadUserProfile();
}

/// Save user profile
class SaveUserProfile extends ProfileEvent {
  final UserProfile profile;

  const SaveUserProfile(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Update user profile
class UpdateUserProfile extends ProfileEvent {
  final UserProfile profile;

  const UpdateUserProfile(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Delete user profile
class DeleteUserProfile extends ProfileEvent {
  const DeleteUserProfile();
}

/// Check if profile exists
class CheckProfileExists extends ProfileEvent {
  const CheckProfileExists();
}
