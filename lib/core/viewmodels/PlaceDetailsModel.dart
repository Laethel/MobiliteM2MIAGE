import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/models/client/OpeningHours.dart' as app;
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';
import 'package:google_maps_webservice/places.dart';

class PlaceDetailsModel extends BaseModel {

  Widget openingHoursWidget;
  String openNow;
  Map<String, Color> openNowColor;
  bool isFavorite = false;
  bool phoneIsAvailable = false;

  Widget getOpeningHoursWidget(PlaceDetails place) {

    List<Widget> openingHoursWidgets = new List<Widget>();

    place.openingHours.weekdayText.forEach((openingHourString) {
      openingHoursWidgets.add(Text(formatOpeningHours(openingHourString)));
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: openingHoursWidgets
    );
  }

  String formatOpeningHours(String openingHourString) {

    openingHourString = openingHourString.replaceAll("Monday", "Lundi");
    openingHourString = openingHourString.replaceAll("Tuesday", "Mardi");
    openingHourString = openingHourString.replaceAll("Wednesday", "Mercredi");
    openingHourString = openingHourString.replaceAll("Thursday", "Jeudi");
    openingHourString = openingHourString.replaceAll("Friday", "Vendredi");
    openingHourString = openingHourString.replaceAll("Saturday", "Samedi");
    openingHourString = openingHourString.replaceAll("Sunday", "Dimanche");
    return openingHourString.replaceAll("Closed", "Fermé");
  }
}