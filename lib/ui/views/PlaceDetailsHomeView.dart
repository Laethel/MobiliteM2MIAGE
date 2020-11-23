import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'package:mobilitem2miage/core/viewmodels/PlaceDetailsHomeModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobilitem2miage/ui/views/PlaceDetailsInformationsView.dart';
import 'package:mobilitem2miage/ui/views/PlaceDetailsPostsView.dart';
import 'package:provider/provider.dart';

class PlaceDetailsHomeView extends StatefulWidget {

  PlaceDetails place;

  PlaceDetailsHomeView({this.place});

  @override
  State<StatefulWidget> createState() {

    return PlaceDetailsHomeViewState();
  }
}

class PlaceDetailsHomeViewState extends State<PlaceDetailsHomeView> {

  @override
  Widget build(BuildContext context) {

    var appState = Provider.of<AppState>(context);

    return BaseView<PlaceDetailsHomeModel>(
      onModelReady: (model) {

        /// Set favorites to true if present in placeLiked
        if (appState.placesLiked.where((placeLiked) => placeLiked.placeId == widget.place.placeId).length == 1) {
          model.isFavorite = true;
        }
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
        body: LiquidSwipe(
          enableSlideIcon: true,
          slideIconWidget: Padding(
            padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.arrowsAltH,
                  size: 22.0,
                ),
                Text(
                  "Swipe",
                  style: TextStyle(
                    fontSize: 12.0,
                  )
                )
              ]
            ),
          ),
          pages: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                      flex: 90,
                      child: PlaceDetailsInformationsView(place: widget.place)
                  ),
                  Expanded(
                    child: model.generateIndicator(1),
                    flex: 10,
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    flex: 90,
                    child: PlaceDetailsPostsView(place: widget.place),
                  ),
                  Expanded(
                    child: model.generateIndicator(2),
                    flex: 10,
                  )
                ],
              ),
            )
          ]
        )
      )
    );
  }
}