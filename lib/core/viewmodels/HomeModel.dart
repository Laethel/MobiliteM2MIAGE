import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/services/LocationService.dart';
import 'package:mobilitem2miage/core/services/MapService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';
import 'package:mobilitem2miage/ui/views/AccountView.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:mobilitem2miage/ui/views/LoginView.dart';
import 'package:mobilitem2miage/ui/views/MapView.dart';
import 'package:mobilitem2miage/ui/views/PlaceView.dart';

class HomeModel extends BaseModel {

  int currentIndex = 0;
  final pages = [
    MapView(),
    PlaceView(),
    AccountView()
  ];

  Future<void> updateUserLocation(LocationService locationService, UserDao userDao, User user) {

    locationService.location.onLocationChanged.listen((locationData) async {

      /// If currentLocation as changed, refresh currentlocation with the new one
      if (locationService.currentLocation.latitude != locationData.latitude || locationService.currentLocation.longitude != locationData.longitude) {

        locationService.currentLocation = locationData;
        user.location = locationData.latitude.toString() + "," + locationData.longitude.toString();
        userDao.update(
          user,
          {
            "location" : locationData.latitude.toString() + "," + locationData.longitude.toString()
          }
        );
      }
    });
  }

  void onTappedBar(int index) {

    currentIndex = index;
    notifyListeners();
  }
}