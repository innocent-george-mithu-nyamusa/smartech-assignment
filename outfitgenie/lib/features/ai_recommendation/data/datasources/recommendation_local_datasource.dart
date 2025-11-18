import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/outfit_recommendation_model.dart';

/// Recommendation local data source interface
abstract class RecommendationLocalDataSource {
  /// Get cached recommendations
  Future<List<OutfitRecommendationModel>> getCachedRecommendations();

  /// Cache recommendations
  Future<void> cacheRecommendations(List<OutfitRecommendationModel> recommendations);

  /// Get favorite recommendations
  Future<List<OutfitRecommendationModel>> getFavorites();

  /// Save favorite
  Future<void> saveFavorite(OutfitRecommendationModel recommendation);

  /// Remove favorite
  Future<void> removeFavorite(String recommendationId);
}

/// Recommendation local data source implementation
class RecommendationLocalDataSourceImpl implements RecommendationLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cachedRecommendationsKey = 'cached_recommendations';
  static const String favoritesKey = 'favorite_recommendations';

  RecommendationLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<OutfitRecommendationModel>> getCachedRecommendations() async {
    try {
      final jsonString = sharedPreferences.getString(cachedRecommendationsKey);

      if (jsonString == null) {
        throw const CacheException('No cached recommendations found');
      }

      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => OutfitRecommendationModel.fromJson(json))
          .toList();
    } catch (e) {
      throw CacheException('Failed to get cached recommendations: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheRecommendations(
    List<OutfitRecommendationModel> recommendations,
  ) async {
    try {
      final jsonList = recommendations.map((r) => r.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await sharedPreferences.setString(cachedRecommendationsKey, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache recommendations: ${e.toString()}');
    }
  }

  @override
  Future<List<OutfitRecommendationModel>> getFavorites() async {
    try {
      final jsonString = sharedPreferences.getString(favoritesKey);

      if (jsonString == null) {
        return [];
      }

      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => OutfitRecommendationModel.fromJson(json))
          .toList();
    } catch (e) {
      throw CacheException('Failed to get favorites: ${e.toString()}');
    }
  }

  @override
  Future<void> saveFavorite(OutfitRecommendationModel recommendation) async {
    try {
      final favorites = await getFavorites();

      // Check if already exists
      if (!favorites.any((f) => f.id == recommendation.id)) {
        favorites.add(recommendation);
        final jsonList = favorites.map((r) => r.toJson()).toList();
        final jsonString = jsonEncode(jsonList);
        await sharedPreferences.setString(favoritesKey, jsonString);
      }
    } catch (e) {
      throw CacheException('Failed to save favorite: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFavorite(String recommendationId) async {
    try {
      final favorites = await getFavorites();
      favorites.removeWhere((f) => f.id == recommendationId);

      final jsonList = favorites.map((r) => r.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await sharedPreferences.setString(favoritesKey, jsonString);
    } catch (e) {
      throw CacheException('Failed to remove favorite: ${e.toString()}');
    }
  }
}
