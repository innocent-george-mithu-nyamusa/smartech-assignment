import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/outfit_recommendation.dart';

part 'outfit_recommendation_model.g.dart';

/// Outfit recommendation data model
@JsonSerializable()
class OutfitRecommendationModel extends OutfitRecommendation {
  const OutfitRecommendationModel({
    required super.id,
    required super.name,
    required super.description,
    required super.items,
    required super.colors,
    required super.style,
    required super.occasion,
    required super.confidenceScore,
    super.imageUrl,
    required super.createdAt,
  });

  /// From JSON (Backend API format)
  factory OutfitRecommendationModel.fromJson(Map<String, dynamic> json) {
    return OutfitRecommendationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      items: (json['items'] as List<dynamic>).map((e) => e as String).toList(),
      colors: (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
      style: json['style'] as String,
      occasion: json['occasion'] as String,
      confidenceScore: (json['confidence_score'] as num).toDouble(),
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() => _$OutfitRecommendationModelToJson(this);

  /// To entity
  OutfitRecommendation toEntity() {
    return OutfitRecommendation(
      id: id,
      name: name,
      description: description,
      items: items,
      colors: colors,
      style: style,
      occasion: occasion,
      confidenceScore: confidenceScore,
      imageUrl: imageUrl,
      createdAt: createdAt,
    );
  }

  /// From entity
  factory OutfitRecommendationModel.fromEntity(OutfitRecommendation recommendation) {
    return OutfitRecommendationModel(
      id: recommendation.id,
      name: recommendation.name,
      description: recommendation.description,
      items: recommendation.items,
      colors: recommendation.colors,
      style: recommendation.style,
      occasion: recommendation.occasion,
      confidenceScore: recommendation.confidenceScore,
      imageUrl: recommendation.imageUrl,
      createdAt: recommendation.createdAt,
    );
  }
}
