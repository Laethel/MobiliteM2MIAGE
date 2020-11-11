

import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class LocationService extends ChangeNotifier {

  static final LocationService _singleton = LocationService._internal();

  factory LocationService() {

    return _singleton;
  }

  LocationService._internal();

  LocationData currentLocation;

  Future<LocationData> getCurrentLocation() async {

    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }
}