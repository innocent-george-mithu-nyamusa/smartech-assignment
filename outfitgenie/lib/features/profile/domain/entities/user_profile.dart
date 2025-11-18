import 'package:equatable/equatable.dart';

/// User profile entity
class UserProfile extends Equatable {
  final String id;
  final String name;
  final String? email;
  final List<String> preferredStyles;
  final List<String> preferredColors;
  final List<String> avoidColors;
  final String? location;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.name,
    this.email,
    required this.preferredStyles,
    required this.preferredColors,
    this.avoidColors = const [],
    this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create empty profile
  factory UserProfile.empty() {
    final now = DateTime.now();
    return UserProfile(
      id: '',
      name: '',
      preferredStyles: const [],
      preferredColors: const [],
      avoidColors: const [],
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Copy with method
  UserProfile copyWith({
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
    return UserProfile(
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

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        preferredStyles,
        preferredColors,
        avoidColors,
        location,
        createdAt,
        updatedAt,
      ];
}
