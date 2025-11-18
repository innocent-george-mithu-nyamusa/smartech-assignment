import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_profile.dart';

part 'user_profile_model.g.dart';

/// User profile data model
@JsonSerializable()
class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.name,
    super.email,
    required super.preferredStyles,
    required super.preferredColors,
    super.avoidColors,
    super.location,
    required super.createdAt,
    required super.updatedAt,
  });

  /// From JSON
  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  /// From entity
  factory UserProfileModel.fromEntity(UserProfile profile) {
    return UserProfileModel(
      id: profile.id,
      name: profile.name,
      email: profile.email,
      preferredStyles: profile.preferredStyles,
      preferredColors: profile.preferredColors,
      avoidColors: profile.avoidColors,
      location: profile.location,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    );
  }

  /// To entity
  UserProfile toEntity() {
    return UserProfile(
      id: id,
      name: name,
      email: email,
      preferredStyles: preferredStyles,
      preferredColors: preferredColors,
      avoidColors: avoidColors,
      location: location,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Copy with for model
  @override
  UserProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    List<String>? preferredStyles,
    List<String>? preferredColors,
    List<String>? avoidColors,
    String? location,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      preferredStyles: preferredStyles ?? this.preferredStyles,
      preferredColors: preferredColors ?? this.preferredColors,
      avoidColors: avoidColors ?? this.avoidColors,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
