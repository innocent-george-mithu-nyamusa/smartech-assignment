import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_profile_model.dart';

/// Profile local data source interface
abstract class ProfileLocalDataSource {
  /// Get cached user profile
  Future<UserProfileModel> getCachedUserProfile();

  /// Cache user profile
  Future<void> cacheUserProfile(UserProfileModel profile);

  /// Delete cached profile
  Future<void> deleteCachedProfile();

  /// Check if profile exists
  Future<bool> hasProfile();
}

/// Profile local data source implementation
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProfileLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<UserProfileModel> getCachedUserProfile() async {
    try {
      final jsonString = sharedPreferences.getString(AppConstants.userProfileKey);

      if (jsonString == null) {
        throw const CacheException('No cached profile found');
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserProfileModel.fromJson(json);
    } catch (e) {
      throw CacheException('Failed to get cached profile: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheUserProfile(UserProfileModel profile) async {
    try {
      final jsonString = jsonEncode(profile.toJson());
      await sharedPreferences.setString(
        AppConstants.userProfileKey,
        jsonString,
      );
    } catch (e) {
      throw CacheException('Failed to cache profile: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteCachedProfile() async {
    try {
      await sharedPreferences.remove(AppConstants.userProfileKey);
    } catch (e) {
      throw CacheException('Failed to delete cached profile: ${e.toString()}');
    }
  }

  @override
  Future<bool> hasProfile() async {
    return sharedPreferences.containsKey(AppConstants.userProfileKey);
  }
}
