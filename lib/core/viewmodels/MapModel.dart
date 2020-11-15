import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobilitem2miage/core/enum/ViewState.dart';
import 'package:mobilitem2miage/core/models/client/PointOfInterest.dart';
import 'package:mobilitem2miage/core/models/client/Tag.dart';
import 'package:mobilitem2miage/core/services/LocationService.dart';
import 'package:mobilitem2miage/core/services/MapService.dart';
import 'package:mobilitem2miage/core/services/PlaceService.dart';
import 'package:mobilitem2miage/core/services/dao/PointOfInterestDao.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';
import 'package:google_maps_webservice/places.dart';

/// TODO : Trouver un moyen de réduire les lectures Firebase parce que le code actuel pompe énormement en lectures
/// https://console.firebase.google.com/u/0/project/mobilitem2miage/firestore/usage/last-24h/reads
class MapModel extends BaseModel {

  /// Filter is disable by default when opening the app
  bool filterEnable = false;

  GoogleMapController controller;
  Map<Marker, Tag> pins = Map<Marker, Tag>();
  List<PlacesSearchResult> places = List<PlacesSearchResult>();
  List<Tag> tags = new List<Tag>();

  Future<void> listenLocation(LocationService locationService) {

    MapService mapProvider = MapService();
    LocationService locationProvider = LocationService();

    locationService.location.onLocationChanged.listen((locationData) async {

      /// If currentLocation as changed, refresh currentlocation with the new one
      if (locationService.currentLocation.latitude != locationData.latitude || locationService.currentLocation.longitude != locationData.longitude) {

        locationService.currentLocation = locationData;

        this.controller.animateCamera(
          CameraUpdate.newCameraPosition(await mapProvider.getCameraPositionWithActualZoom(this.controller, locationProvider.currentLocation)),
        );
        notifyListeners();
      }
    });
  }

  Future<void> displayPlacesByTag(Tag tag, PlaceService placeProvider, LocationService locationProvider, PointOfInterestDao pointOfInterestDao) async {

    this.setState(ViewState.Busy);

    tag.isActive = !tag.isActive;
    if (tag.isActive) {


      /// For all googleType present on Tag
      /// Ex. : "Culture" containt "touristattraction" and "museum" googleType
      tag.googleType.forEach((googleType) async {

        await placeProvider.getNearbyPlaces(locationProvider.currentLocation, googleType).then((places) => {
          places.forEach((place) async {

            /// Adding new place to current markers display on the map
            this.pins.putIfAbsent(new Marker(
              markerId: MarkerId(place.placeId),
              icon: BitmapDescriptor.fromBytes(
                  await MapService.getBytesFromAsset(
                      "res/assets/maps/markers/" + tag.label + "_b.png",
                      130
                  )
              ),
              infoWindow: InfoWindow(
                  onTap: () {
                    print("click on : " + place.name + " place");
                  },
                  snippet: "Cliquez pour voir le détail",
                  title: place.name
              ),
              position: LatLng(place.geometry.location.lat, place.geometry.location.lng),
            ), () => tag);

            /// If the point of interest doesn't exist yet in the Firestore, we add it
            PointOfInterest pointOfInterest = await pointOfInterestDao.getById(place.placeId);
            if (pointOfInterest == null) {

              await pointOfInterestDao.add(
                  new PointOfInterest(
                      id: place.placeId,
                      name: place.name,
                      latitude: place.geometry.location.lat,
                      longitude: place.geometry.location.lng,
                      theme: tag.label.toLowerCase(),
                      subTheme: googleType
                  )
              );
            }

            /// TODO : Le chargement se termine avant que les icons apparaissent sur la carte
            this.setState(ViewState.Idle);

          })
        }).catchError((error) {
          /// TODO : mettre un toast message
          print("No place found");
          this.setState(ViewState.Idle);
        });
      });
    } else {
      /// Remove markers where google type is equal to google type of theme which is remove
      /// exemple : remove all "cofee" google type when "Gastronomie" theme is removed
      this.pins.removeWhere((key, value) => value.googleType == tag.googleType);
      this.setState(ViewState.Idle);
    }
  }
}