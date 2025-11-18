import 'package:equatable/equatable.dart';

/// Outfit recommendation entity
class OutfitRecommendation extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> items;
  final List<String> colors;
  final String style;
  final String occasion;
  final double confidenceScore;
  final String? imageUrl;
  final DateTime createdAt;

  const OutfitRecommendation({
    required this.id,
    required this.name,
    required this.description,
    required this.items,
    required this.colors,
    required this.style,
    required this.occasion,
    required this.confidenceScore,
    this.imageUrl,
    required this.createdAt,
  });

  /// Check if this is a high confidence recommendation
  bool get isHighConfidence => confidenceScore >= 0.8;

  /// Get confidence level as string
  String get confidenceLevel {
    if (confidenceScore >= 0.9) return 'Excellent';
    if (confidenceScore >= 0.8) return 'Very Good';
    if (confidenceScore >= 0.7) return 'Good';
    if (confidenceScore >= 0.6) return 'Fair';
    return 'Low';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        items,
        colors,
        style,
        occasion,
        confidenceScore,
        imageUrl,
        createdAt,
      ];
}
