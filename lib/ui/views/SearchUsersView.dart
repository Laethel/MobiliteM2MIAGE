import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong/latlong.dart';
import 'package:mobilitem2miage/core/enum/ViewState.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/LocationService.dart';
import 'package:mobilitem2miage/core/services/PlaceService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'package:mobilitem2miage/core/viewmodels/SearchUsersModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:provider/provider.dart';

class SearchUsersView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return SearchUsersViewState();
  }
}

class SearchUsersViewState extends State<SearchUsersView> {

  @override
  Widget build(BuildContext context) {

    var userDao = Provider.of<UserDao>(context);
    var placeProvider = Provider.of<PlaceService>(context);
    var locationProvider = Provider.of<LocationService>(context);
    var appState = Provider.of<AppState>(context);

    return BaseView<SearchUsersModel>(
      onModelReady: (model) {

        model.searchBar = new SearchBar(
          hintText: "Rechercher un utilisateur",
          inBar: false,
          setState: setState,
          onSubmitted: (value) async {

            model.usersCard.clear();
            model.notifyListeners();
            if (value == "") return;
            Map<User, double> usersWithDistance = new Map<User, double>();
            List<User> users = await userDao.fetch();

            model.filterByName(users, value).forEach((user) {
              usersWithDistance.putIfAbsent(user, () => locationProvider.distanceBetweenUser(
                  new LatLng(
                      double.parse(appState.user.location.split(",")[0]),
                      double.parse(appState.user.location.split(",")[1])
                  ),
                  user
              ));
            });

            model.usersCard = model.getUsersCardByName(appState.user, usersWithDistance);
            model.notifyListeners();
          },
          onChanged: (value) async {

            model.usersCard.clear();
            model.notifyListeners();
            if (value == "") return;
            Map<User, double> usersWithDistance = new Map<User, double>();
            List<User> users = await userDao.fetch();

            model.filterByName(users, value).forEach((user) {
              usersWithDistance.putIfAbsent(user, () => locationProvider.distanceBetweenUser(
                  new LatLng(
                      double.parse(appState.user.location.split(",")[0]),
                      double.parse(appState.user.location.split(",")[1])
                  ),
                  user
              ));
            });

            model.usersCard = model.getUserCardSuggestion(appState.user, usersWithDistance);
            model.notifyListeners();
          },
          buildDefaultAppBar: model.buildAppBar
        );
        placeProvider.initTags(model.tags);

      },
      builder: (context, model, child) => Scaffold(
        appBar: model.searchBar.build(context),
        body: Column(
          children: [
            model.filterEnable ? Expanded(
              child: Container(
                color: Color(0xFF809cc5),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.tags.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF809cc5),
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  model.tags[index].isActive = !model.tags[index].isActive;

                                  /// Si on enlève ça, on peut en choisir plusieurs
                                  model.tags.forEach((tag) {
                                    if (model.tags[index] != tag)
                                      tag.isActive = false;
                                  });
                                  ///###############################################

                                  /// Get users around current user
                                  List<User> users = await userDao.fetch();
                                  Map<User, double> usersWithDistance = await locationProvider.searchUsersWithRadius(
                                    users,
                                    new LatLng(double.parse(appState.user.location.split(",")[0]), double.parse(appState.user.location.split(",")[1])),
                                    10000
                                  );
                                  model.usersCard = model.getUsersCardByTheme(appState.user, usersWithDistance);
                                  model.notifyListeners();
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
              flex: 10,
            ) : SizedBox.shrink(),
            model.usersCard != null && model.usersCard.isNotEmpty ? Expanded(
              child: ListView.builder(
                  itemCount: model.usersCard.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/userProfil", arguments:  model.usersCard.keys.toList()[index]);
                          },
                          child: model.usersCard.values.toList()[index]
                        )
                    );
                  }
              ),
              flex: 90,
            ) : Expanded(
              child: Center(
                child: model.state == ViewState.Idle ? Text("") : CircularProgressIndicator(),
              ),
              flex: 90,
            )
          ],
        ),
      )
    );
  }
}