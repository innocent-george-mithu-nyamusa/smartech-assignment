// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outfit_recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutfitRecommendationModel _$OutfitRecommendationModelFromJson(
        Map<String, dynamic> json) =>
    OutfitRecommendationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      items: (json['items'] as List<dynamic>).map((e) => e as String).toList(),
      colors:
          (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
      style: json['style'] as String,
      occasion: json['occasion'] as String,
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$OutfitRecommendationModelToJson(
        OutfitRecommendationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'items': instance.items,
      'colors': instance.colors,
      'style': instance.style,
      'occasion': instance.occasion,
      'confidenceScore': instance.confidenceScore,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };
