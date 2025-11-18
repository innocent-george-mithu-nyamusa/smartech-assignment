import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/save_user_profile.dart' as usecases;
import '../../domain/usecases/update_user_profile.dart' as usecases;
import 'profile_event.dart';
import 'profile_state.dart';

/// Profile BLoC
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfile getUserProfile;
  final usecases.SaveUserProfile saveUserProfile;
  final usecases.UpdateUserProfile updateUserProfile;

  ProfileBloc({
    required this.getUserProfile,
    required this.saveUserProfile,
    required this.updateUserProfile,
  }) : super(const ProfileInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<SaveUserProfile>(_onSaveUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  Future<void> _onLoadUserProfile(
    LoadUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final result = await getUserProfile();

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  Future<void> _onSaveUserProfile(
    SaveUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final result = await saveUserProfile(event.profile);

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => emit(const ProfileSaved()),
    );
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final result = await updateUserProfile(event.profile);

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileUpdated(profile)),
    );
  }
}
