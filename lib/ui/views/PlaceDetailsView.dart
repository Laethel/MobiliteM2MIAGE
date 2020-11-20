import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilitem2miage/core/enum/ViewState.dart';
import 'package:mobilitem2miage/core/services/MapService.dart';
import 'package:mobilitem2miage/core/services/PlaceService.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'package:mobilitem2miage/core/viewmodels/PlaceDetailsModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_webservice/places.dart';

class PlaceDetailsView extends StatefulWidget {

  PlaceDetails place;

  PlaceDetailsView({this.place});

  @override
  State<StatefulWidget> createState() {
    return PlaceDetailsViewState();
  }
}

class PlaceDetailsViewState extends State<PlaceDetailsView> {

  @override
  Widget build(BuildContext context) {

    var appState = Provider.of<AppState>(context);
    var placeProvider = Provider.of<PlaceService>(context);

    return BaseView<PlaceDetailsModel>(
      onModelReady: (model) async {

        model.setState(ViewState.Busy);

        if (widget.place.openingHours == null) {
          model.openNow = "Non renseigné";
        } else {
          widget.place.openingHours.openNow ? model.openNow = "Ouvert" : model.openNow = "Fermé";
          model.openingHoursWidget = model.getOpeningHoursWidget(widget.place);
        }

        /// Set favorites to true if present in placeLiked
        if (appState.placesLiked.where((placeLiked) => placeLiked.placeId == widget.place.placeId).length == 1) {
          model.isFavorite = true;
        }

        if (widget.place.internationalPhoneNumber != null) {
          model.phoneIsAvailable = true;
        }

        model.openNowColor = {
          "Non renseigné" : Colors.grey,
          "Ouvert" : Colors.green,
          "Fermé" : Colors.redAccent,
        };

        model.setState(ViewState.Idle);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.place.name),
          backgroundColor: Color(0xFF809cc5),
          actions: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: () {
                  model.isFavorite = !model.isFavorite;
                  if (model.isFavorite) {
                    appState.placesLiked.add(widget.place);
                  } else {
                    appState.placesLiked.removeWhere((placeLiked) => placeLiked.placeId == widget.place.placeId);
                  }
                  model.notifyListeners();
                },
                icon: Icon(
                  model.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: model.isFavorite ? Colors.redAccent : Colors.white,
                ),
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Accueil",
                        style: GoogleFonts.roboto(
                          fontSize: 22.0
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(model.state == ViewState.Busy ? "..." : model.openNow),
                        Icon(
                          Icons.fiber_manual_record,
                          color: model.state == ViewState.Busy ? Colors.grey : model.openNowColor[model.openNow],
                        ),
                        IconButton(
                          onPressed: !model.phoneIsAvailable ? null : () async {
                            if (model.state == ViewState.Idle) {
                              widget.place.internationalPhoneNumber != null ? await FlutterPhoneDirectCaller.callNumber(widget.place.internationalPhoneNumber) : print("Pas de numéro");
                              print("Numéro : " + (widget.place.internationalPhoneNumber != null ? widget.place.internationalPhoneNumber : "pas de numéro"));
                            }
                          },
                          icon: Icon(Icons.phone),
                        )
                      ],
                    )
                  ],
                ),
              ),

              model.openingHoursWidget != null ? model.openingHoursWidget : SizedBox.shrink(),
              SizedBox(height: 20.0),

              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.network(
                  "https://maps.googleapis.com/maps/api/staticmap?" +
                  "center=" + widget.place.geometry.location.lat.toString() + "," + widget.place.geometry.location.lng.toString() +
                  "&zoom=16" +
                  "&size=400x300" +
                  "&markers=color:red|" + widget.place.geometry.location.lat.toString() + "," + widget.place.geometry.location.lng.toString() +
                  "&key=AIzaSyAXOHJNhVKks6HvFHj6Y5TYCxF3MJP1b9Y"
                ),
              ),

              Text(model.state != ViewState.Busy ? widget.place.formattedAddress : ""),

              FlatButton(
                onPressed: () {
                  appState.placesVisited.add(widget.place);
                  Navigator.pop(context);
                },
                child: Text("J'y étais !"),
              )
            ],
          )
        )
      )
    );
  }
}