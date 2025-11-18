import 'package:equatable/equatable.dart';

import '../../../profile/domain/entities/user_profile.dart';
import '../../../weather/domain/entities/weather.dart';

/// Recommendation request entity
class RecommendationRequest extends Equatable {
  final UserProfile userProfile;
  final Weather weather;
  final String occasion;
  final String? additionalNotes;

  const RecommendationRequest({
    required this.userProfile,
    required this.weather,
    required this.occasion,
    this.additionalNotes,
  });

  @override
  List<Object?> get props => [
        userProfile,
        weather,
        occasion,
        additionalNotes,
      ];
}
