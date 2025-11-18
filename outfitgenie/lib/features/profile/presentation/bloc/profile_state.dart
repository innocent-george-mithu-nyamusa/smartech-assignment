import 'package:equatable/equatable.dart';

import '../../domain/entities/user_profile.dart';

/// Profile states
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Loading state
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// Profile loaded successfully
class ProfileLoaded extends ProfileState {
  final UserProfile profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Profile saved successfully
class ProfileSaved extends ProfileState {
  const ProfileSaved();
}

/// Profile updated successfully
class ProfileUpdated extends ProfileState {
  final UserProfile profile;

  const ProfileUpdated(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Profile deleted successfully
class ProfileDeleted extends ProfileState {
  const ProfileDeleted();
}

/// Profile exists check result
class ProfileExistsChecked extends ProfileState {
  final bool exists;

  const ProfileExistsChecked(this.exists);

  @override
  List<Object?> get props => [exists];
}

/// Profile error
class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Profile empty (no profile exists)
class ProfileEmpty extends ProfileState {
  const ProfileEmpty();
}
