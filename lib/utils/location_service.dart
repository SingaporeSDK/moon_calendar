import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<bool> requestLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      final result = await Geolocator.requestPermission();
      return result == LocationPermission.whileInUse || 
             result == LocationPermission.always;
    } else if (permission == LocationPermission.deniedForever) {
      // Open app settings if permission is denied forever
      await Geolocator.openLocationSettings();
      return false;
    }
    
    return permission == LocationPermission.whileInUse || 
           permission == LocationPermission.always;
  }

  static Future<String?> getCurrentLocation() async {
    try {
      final hasPermission = await requestLocationPermission();
      
      if (!hasPermission) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      // Reverse geocode to get location name
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        
        // Format location based on what's available
        String locationName = '';
        
        if (place.locality != null && place.locality!.isNotEmpty) {
          locationName = place.locality!;
        } else if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
          locationName = place.administrativeArea!;
        }
        
        // Add country if available
        if (place.country != null && place.country!.isNotEmpty) {
          if (locationName.isNotEmpty) {
            locationName += ', ${place.country}';
          } else {
            locationName = place.country!;
          }
        }
        
        return locationName;
      }
      
      // Fallback to coordinates
      return '${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)}';
    } catch (e) {
      // Error getting location - return null
      return null;
    }
  }
}
