import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobilitem2miage/core/models/client/Pin.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/services/LocationService.dart';
import 'package:mobilitem2miage/core/services/PlaceService.dart';
import 'package:mobilitem2miage/core/viewmodels/HomeModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var locationProvider = Provider.of<LocationService>(context);
    var placeProvider = Provider.of<PlaceService>(context);

    return BaseView<HomeModel>(
      onModelReady: (model) async {
      },
      builder: (context, model, child) => Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            GoogleMap(
              markers: model.pins.keys.toSet(),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              compassEnabled: true,
              initialCameraPosition: model.getCameraPosition(locationProvider.currentLocation),
              onMapCreated: (GoogleMapController controller) async {
                /// Instanciate GoogleMapController
                model.controller = controller;
                model.initMapStyle();
                model.initTags();
                model.notifyListeners();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 80.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: model.filterEnable ? Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child:  ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.tags.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(90.0),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        model.tags[index].isActive = !model.tags[index].isActive;
                                        if (model.tags[index].isActive) {
                                          await placeProvider.getNearbyPlaces(locationProvider.currentLocation, model.tags[index].googleType).then((places) => {
                                            places.forEach((place) async {
                                              model.pins.putIfAbsent(new Marker(
                                                markerId: MarkerId(place.placeId),
                                                icon: BitmapDescriptor.fromBytes(
                                                  await placeProvider.getBytesFromAsset(
                                                      "res/assets/maps/markers/" + model.tags[index].googleType + "_b.png",
                                                      130
                                                  )
                                                ),
                                                infoWindow: InfoWindow(
                                                    onTap: () {
                                                      print("Tapos : " + place.name);
                                                    },
                                                    snippet: "Cliquez pour voir le détail",
                                                    title: place.name
                                                ),
                                                position: LatLng(place.geometry.location.lat, place.geometry.location.lng),
                                              ), () => model.tags[index]);
                                              /*model.markers.add(
                                                new Pin(
                                                  marker: new Marker(
                                                    markerId: MarkerId(place.placeId),
                                                    infoWindow: InfoWindow(
                                                        onTap: () {
                                                          print("Tapos : " + place.name);
                                                        },
                                                        snippet: "Cliquez pour voir le détail",
                                                        title: place.name
                                                    ),
                                                    position: LatLng(place.geometry.location.lat, place.geometry.location.lng),

                                                  ),
                                                  tag: model.tags[index]
                                                )
                                              );*/

                                              model.notifyListeners();
                                            })
                                          });
                                        } else {
                                          /// Remove markers where google type is equal to google type of theme which is remove
                                          /// exemple : remove all "cofee" google type when "Gastronomie" theme is removed
                                          model.pins.removeWhere((key, value) => value.googleType == model.tags[index].googleType);
                                        }
                                        print("hey");
                                        model.notifyListeners();
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                              model.tags[index].icon,
                                              color: model.tags[index].isActive ?  Color(0xFF50627b) : Color(0xFFa0c4f7)
                                          ),
                                          Text(
                                            model.tags[index].label,
                                            style: GoogleFonts.roboto(
                                                color: model.tags[index].isActive ? Color(0xFF50627b) : Color(0xFFa0c4f7)
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                            );
                          }
                      ),
                    ),
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(90.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                  ) : SizedBox.shrink()
                )
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: model.filterEnable ? Colors.white : Color(0xFF809cc5),
                child: Icon(
                  Icons.filter_list,
                  color: model.filterEnable ? Color(0xFF809cc5) : Colors.white,
                ),
                onPressed: () {
                  model.filterEnable = !model.filterEnable;
                  model.notifyListeners();
                },
              ),
              SizedBox(width: 15),
              FloatingActionButton(
                backgroundColor: Color(0xFF809cc5),
                child: Icon(Icons.my_location),
                onPressed: () async {
                  model.controller.animateCamera(
                    CameraUpdate.newCameraPosition(await model.getCameraPositionWithActualZoom(locationProvider.currentLocation)),
                  );
                },
              ),
            ],
          ),
        )
      )
    );
  }
}