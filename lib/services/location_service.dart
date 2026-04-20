import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    debugPrint("1. -- $permission");

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      debugPrint("2. -- $permission");

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("3. -- $permission");
      await Geolocator.openAppSettings();
      return Future.error(
        'Location permissions are permanently denied, try again to visit app settings',
      );
    }

    return await Geolocator.getCurrentPosition();
  }
}
