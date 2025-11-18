// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      preferredStyles: (json['preferredStyles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      preferredColors: (json['preferredColors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      avoidColors: (json['avoidColors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      location: json['location'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'preferredStyles': instance.preferredStyles,
      'preferredColors': instance.preferredColors,
      'avoidColors': instance.avoidColors,
      'location': instance.location,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
