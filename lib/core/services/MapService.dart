import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapService extends ChangeNotifier {

  Future<CameraPosition> getCameraPositionWithActualZoom(GoogleMapController controller, LocationData location) async {

    return CameraPosition(
        target: LatLng(
            location.latitude,
            location.longitude
        ),
        zoom: await controller.getZoomLevel()
    );
  }

  CameraPosition getCameraPosition(LocationData location) {

    return CameraPosition(
        target: LatLng(
            location.latitude,
            location.longitude
        ),
        zoom: 16
    );
  }

  void initMapStyle(GoogleMapController controller) {

    rootBundle.loadString('res/assets/maps/retro.json').then((string) {
      controller.setMapStyle(string);
    });
  }

  /// TODO : Mettre ça dans un service MapService
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png)).buffer.asUint8List();
  }

}