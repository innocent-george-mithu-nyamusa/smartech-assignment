import 'package:geolocator/geolocator.dart';

import '../../../../core/error/exceptions.dart';
import '../models/location_model.dart';

/// Location data source interface
abstract class LocationDataSource {
  /// Get current location
  Future<LocationModel> getCurrentLocation();

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled();

  /// Request location permission
  Future<bool> requestLocationPermission();
}

/// Location data source implementation
class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<LocationModel> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw const ServerException('Location services are disabled');
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw const ServerException('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw const ServerException(
          'Location permissions are permanently denied',
        );
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to get location: ${e.toString()}');
    }
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return permission != LocationPermission.denied;
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}
