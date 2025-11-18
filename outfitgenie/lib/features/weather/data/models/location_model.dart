import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/location.dart';

part 'location_model.g.dart';

/// Location data model
@JsonSerializable()
class LocationModel extends Location {
  const LocationModel({
    required super.latitude,
    required super.longitude,
    super.city,
    super.country,
  });

  /// From JSON
  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  /// To entity
  Location toEntity() {
    return Location(
      latitude: latitude,
      longitude: longitude,
      city: city,
      country: country,
    );
  }

  /// From entity
  factory LocationModel.fromEntity(Location location) {
    return LocationModel(
      latitude: location.latitude,
      longitude: location.longitude,
      city: location.city,
      country: location.country,
    );
  }
}
