import 'package:flutter/cupertino.dart';
import 'package:mobilitem2miage/core/models/client/PointOfInterest.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:google_maps_webservice/places.dart';

class AppState with ChangeNotifier {

  PlacesSearchResult place;
  List<PlaceDetails> placesVisited = new List<PlaceDetails>();
  List<PlaceDetails> placesLiked = new List<PlaceDetails>();
  PointOfInterest currentPointOfInterest;
  User user;
}