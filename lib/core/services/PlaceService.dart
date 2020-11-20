import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;
import 'package:mobilitem2miage/core/models/client/Tag.dart';

class PlaceService extends ChangeNotifier {

  static String kGoogleApiKey = "AIzaSyAXOHJNhVKks6HvFHj6Y5TYCxF3MJP1b9Y";

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  void initTags(List<Tag> tags) {

    Map<String, IconData> tagsData = {
      "Culture": FontAwesomeIcons.university,
      "Sport": FontAwesomeIcons.dumbbell,
      "Gastronomie": FontAwesomeIcons.utensils
    };

    tagsData.forEach((key, value) {
      if (this.getGoogleType(key) != "None")  {
        tags.add(
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

  List<String> getGoogleType(String key) {

    /// TODO : Mettre ça dans un fichier JSON
    switch(key) {
      case "Culture":
        return [
          "touristattraction",
          "museum"
        ];
        break;
      case "Sport":
        return [
          "gym"
        ];
        break;
      case "Gastronomie":
        return [
          "restaurant"
        ];
        break;
      default:
        return ["None"];
        break;
    }
  }

  Future<PlacesDetailsResponse> getPlaceDetails(PlacesSearchResult place) async {

    return await _places.getDetailsByPlaceId(place.placeId);
  }

  Future<List<PlacesSearchResult>> getNearbyPlaces(loc.LocationData center, String type) async {

    final location = Location(center.latitude, center.longitude);
    PlacesSearchResponse response = await _places.searchNearbyWithRadius(location, 10000, keyword: type);

    if (response.status == "OK") {

      return response.results;

    } else {

      print("Error getting nearby place : " + response.errorMessage);
      return null;
    }
  }
}