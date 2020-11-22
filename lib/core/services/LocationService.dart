import 'package:flutter/cupertino.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';

class LocationService extends ChangeNotifier {

  static final LocationService _singleton = LocationService._internal();

  factory LocationService() {

    return _singleton;
  }

  LocationService._internal();

  Location location = new Location();
  LocationData currentLocation;

  Future<LocationData> getCurrentLocation() async {

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

  double distanceBetweenUser(LatLng location, User user2) {

    Distance distance = new Distance();

    return distance.as(
      LengthUnit.Meter,
      location,
      new LatLng(double.parse(user2.location.split(",")[0]), double.parse(user2.location.split(",")[1]),)
    );
  }

  Future<Map<User, double>> searchUsersWithRadius(List<User> users, LatLng location, double radius) async {

    /*Map<User, double> res = new Map<User, double>();
    await userDao.fetch().then((users) => {
      users.forEach((searchUser) {
        if (radius > this._distanceBetweenUser(location, searchUser)) {
          res.putIfAbsent(searchUser, () => this._distanceBetweenUser(location, searchUser));
        }
      })

    }).whenComplete(() {
      return res;
    });
  }*/

    Map<User, double> res = new Map<User, double>();
    users.forEach((searchUser) {
      if (radius > this.distanceBetweenUser(location, searchUser)) {
        res.putIfAbsent(
            searchUser, () => this.distanceBetweenUser(location, searchUser));
      }
    });

    return res;
  }
}