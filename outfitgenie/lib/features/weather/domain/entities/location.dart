import 'package:equatable/equatable.dart';

/// Location entity
class Location extends Equatable {
  final double latitude;
  final double longitude;
  final String? city;
  final String? country;

  const Location({
    required this.latitude,
    required this.longitude,
    this.city,
    this.country,
  });

  @override
  List<Object?> get props => [latitude, longitude, city, country];
}
