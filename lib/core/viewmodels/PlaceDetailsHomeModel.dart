import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';
import 'package:mobilitem2miage/ui/views/PlaceDetailsInformationsView.dart';
import 'package:mobilitem2miage/ui/views/PlaceDetailsPostsView.dart';
import 'package:google_maps_webservice/places.dart';

class PlaceDetailsHomeModel extends BaseModel {

  bool isFavorite = false;

  Widget generateIndicator(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
            index == 1 ? FontAwesomeIcons.solidCircle : FontAwesomeIcons.circle,
            size: 14.0
        ),
        SizedBox(width: 5.0),
        Icon(
            index == 2 ? FontAwesomeIcons.solidCircle : FontAwesomeIcons.circle,
            size: 14.0
        ),
      ],
    );
  }
}