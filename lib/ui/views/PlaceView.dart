import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'package:mobilitem2miage/core/viewmodels/PlaceModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:provider/provider.dart';

class PlaceView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return PlaceViewState();
  }
}

class PlaceViewState extends State<PlaceView> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var appState = Provider.of<AppState>(context);

    return BaseView<PlaceModel>(
      builder: (context, model, child) => Scaffold(
        body: Container(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Visités",
                      style: GoogleFonts.roboto(
                          fontSize: 22.0
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                      height: 200.0,
                      child: appState.placesVisited.isNotEmpty ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: appState.placesVisited.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 300,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/placeDetails", arguments: appState.placesVisited[index]);
                                  },
                                  child: Card(
                                    child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                appState.placesVisited[index].name,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 1.0,
                                              bottom: 1.0,
                                              child: Row(
                                                children: [
                                                  Text(appState.placesVisited[index].rating.toString()),
                                                  Icon(Icons.star, color: Colors.yellow)
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      ) : Center(
                        child: Text("Vous n'avez visité aucun point d'intérêt"),
                      )
                  )
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Favoris",
                      style: GoogleFonts.roboto(
                          fontSize: 22.0
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    height: 200.0,
                    child: appState.placesLiked.isNotEmpty ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: appState.placesLiked.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 300,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/placeDetails", arguments: appState.placesLiked[index]);
                                },
                                child: Card(
                                  child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              appState.placesLiked[index].name,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 1.0,
                                            bottom: 1.0,
                                            child: Row(
                                              children: [
                                                Text(appState.placesLiked[index].rating.toString()),
                                                Icon(Icons.star, color: Colors.yellow)
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ) : Center(
                      child: Text("Vous n'avez aucun favoris"),
                    )
                  )
                ],
              ),
            ],
          )
        )
      )
    );
  }
}