import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;

class PlaceService extends ChangeNotifier {

  static String kGoogleApiKey = "AIzaSyC9BtXawYtyr2drCwE--ZtDPlOVLWT2lAQ";

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

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

  /// TODO : Mettre ça dans un service MapService
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png)).buffer.asUint8List();
  }
}