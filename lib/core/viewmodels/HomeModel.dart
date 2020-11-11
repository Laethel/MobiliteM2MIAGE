import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobilitem2miage/core/models/client/Pin.dart';
import 'package:mobilitem2miage/core/models/client/Tag.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/services/LocationService.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';
import 'package:google_maps_webservice/places.dart';

class HomeModel extends BaseModel {

  bool filterEnable = true;

  LocationService locationService = LocationService();
  GoogleMapController controller;

  Map<Marker, Tag> pins = Map<Marker, Tag>();

  Set<Marker> taMereLaPute = Set<Marker>();
  List<PlacesSearchResult> places = List<PlacesSearchResult>();

  List<Tag> tags = new List<Tag>();

  CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  CameraPosition cameraPosition = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 12.151926040649414
  );

  Future<CameraPosition> getCameraPositionWithActualZoom(LocationData location) async {

    return CameraPosition(
        target: LatLng(
            location.latitude,
            location.longitude
        ),
        zoom: await this.controller.getZoomLevel()
    );
  }

  CameraPosition getCameraPosition(LocationData location) {

    return CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(
          location.latitude,
          location.longitude
        ),
        zoom: 16
    );
  }

  Future<void> getPlace() async {


  }

  void initMapStyle() {

    rootBundle.loadString('res/assets/maps/retro.json').then((string) {
      this.controller.setMapStyle(string);
    });
  }

  void initTags() {

    Map<String, IconData> tagsData = {
      "Culture": FontAwesomeIcons.university,
      "Sport": FontAwesomeIcons.dumbbell,
      "Gastronomie": FontAwesomeIcons.utensils
    };

    tagsData.forEach((key, value) {
      if (this.getGoogleType(key) != "None")  {
        this.tags.add(
          new Tag(
            label: key,
            googleType: this.getGoogleType(key),
            icon: value,
            isActive: false
          )
        );
      }
    });
  }

  String getGoogleType(String key) {

    switch(key) {
      case "Culture":
        return "touristattraction";
        break;
      case "Sport":
        return "gym";
        break;
      case "Gastronomie":
        return "restaurant";
        break;
      default:
        return "None";
        break;
    }
  }

  void initMarkers() {

    //this.markers.add(value)
  }
}