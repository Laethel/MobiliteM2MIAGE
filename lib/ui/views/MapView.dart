import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobilitem2miage/core/enum/ViewState.dart';
import 'package:mobilitem2miage/core/services/LocationService.dart';
import 'package:mobilitem2miage/core/services/MapService.dart';
import 'package:mobilitem2miage/core/services/PlaceService.dart';
import 'package:mobilitem2miage/core/services/dao/PointOfInterestDao.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'package:mobilitem2miage/core/viewmodels/MapModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return MapViewState();
  }
}

class MapViewState extends State<MapView> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var pointOfInterestDao = Provider.of<PointOfInterestDao>(context);
    var locationProvider = Provider.of<LocationService>(context);
    var mapProvider = Provider.of<MapService>(context);
    var placeProvider = Provider.of<PlaceService>(context);
    var appState = Provider.of<AppState>(context);

    return BaseView<MapModel>(
      onModelReady: (model) {
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
              initialCameraPosition: mapProvider.getCameraPosition(locationProvider.currentLocation),
              onMapCreated: (GoogleMapController controller) async {
                /// Instanciate GoogleMapController
                model.controller = controller;
                model.listenLocation(locationProvider);
                mapProvider.initMapStyle(model.controller);
                placeProvider.initTags(model.tags);
                model.notifyListeners();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 80.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                /// To make disappear/appear the filter with animation
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  /// If filter is enable, then show filterMenu (container), else show an empty SizedBox
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
                                      color: Color(0xFF809cc5),
                                      borderRadius: BorderRadius.circular(90.0),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await model.displayPlacesByTag(model.tags[index], placeProvider, locationProvider, pointOfInterestDao, context, appState);
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                              model.tags[index].icon,
                                              color: model.tags[index].isActive ?  Color(0xFF50627b) : Colors.white
                                          ),
                                          Text(
                                            model.tags[index].label,
                                            style: GoogleFonts.roboto(
                                                color: model.tags[index].isActive ? Color(0xFF50627b) : Colors.white
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
                      color: Color(0xFF809cc5),
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
            ),
            Align(
              alignment: Alignment.center,
              /// If place are loading, display a CircularProgressIndicator with a waiting message
              child: model.state == ViewState.Busy ? Stack(
                alignment: Alignment.center,
                children: [
                  /// When places are loading, the user's screen is blocked
                  Container(height: 1000, width: 1000, color: Colors.transparent),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20.0),
                      Text(
                          "Veuillez patientez...",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          )
                      )
                    ],
                  )
                ],
              ) : SizedBox.shrink(),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: "filterBtn",
                backgroundColor: model.filterEnable ? Color(0xFF50627b) : Color(0xFF809cc5),
                child: Icon(
                  Icons.filter_list,
                  color: Colors.white
                ),
                onPressed: () {
                  model.filterEnable = !model.filterEnable;
                  model.notifyListeners();
                },
              ),
              SizedBox(width: 15),
              FloatingActionButton(
                heroTag: "centerBtn",
                backgroundColor: Color(0xFF809cc5),
                child: Icon(Icons.my_location),
                onPressed: () async {
                  model.setState(ViewState.Busy);
                  model.controller.animateCamera(
                    CameraUpdate.newCameraPosition(await mapProvider.getCameraPositionWithActualZoom(model.controller, locationProvider.currentLocation)),
                  );
                  model.setState(ViewState.Idle);
                },
              ),
            ],
          ),
        )
      )
    );
  }
}