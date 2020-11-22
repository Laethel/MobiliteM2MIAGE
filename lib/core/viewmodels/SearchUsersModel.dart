import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong/latlong.dart';
import 'package:mobilitem2miage/core/enum/ViewState.dart';
import 'package:mobilitem2miage/core/models/client/Tag.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/LocationService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';

class SearchUsersModel extends BaseModel {

  TextEditingController searchController = new TextEditingController();
  SearchBar searchBar;
  UserDao userDao = new UserDao();
  bool filterEnable = false;
  List<Tag> tags = new List<Tag>();
  Map<User, Widget> usersCard = new Map<User, Widget>();
  LocationService locationService = new LocationService();

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: this.usersCard.isEmpty ? Text("Recherche") : Text(this.usersCard.length.toString() + " utilisateur" + (this.usersCard.length == 1 ? "" : "(s)") + " trouvé" + (this.usersCard.length == 1 ? "" : "(s)")),
        backgroundColor: Color(0xFF809cc5),
        actions: [
          IconButton(
            onPressed: () {
              this.filterEnable = !this.filterEnable;
              notifyListeners();
            },
            icon: Icon(Icons.filter_list)
          ),
          searchBar.getSearchAction(context),
        ]
    );
  }

  List<User> filterByName(List<User> users, String value) {

    if (users == null || users.isEmpty) return null;

    setState(ViewState.Busy);
    List<User> usersFiltered = new List<User>();

    users.forEach((user) {
      if (
        user.lastName.toLowerCase().startsWith(value.toLowerCase())
        || user.firstName.toLowerCase().startsWith(value.toLowerCase())
        || (user.firstName.toLowerCase() + " " + user.lastName.toLowerCase()).startsWith(value.toLowerCase())
        || (user.lastName.toLowerCase() + " " + user.firstName.toLowerCase()).startsWith(value.toLowerCase())) {
        usersFiltered.add(user);
      }
    });

    setState(ViewState.Idle);
    return usersFiltered;
  }

  Map<User, Widget> getUserCardSuggestion(User user, Map<User, double> usersSuggestion) {

    if (usersSuggestion == null) return null;
    Map<User, Card> cards = new Map<User, Card>();

    usersSuggestion.forEach((userSuggestion, distance) {
      if (user.email != userSuggestion.email) {
        cards.putIfAbsent(userSuggestion, () => Card(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 10.0),
                    Text(userSuggestion.firstName + " " + userSuggestion.lastName),
                  ],
                ),
                Text(distance.toString() + "m")
              ],
            ),
          ),
        ));
      }
    });

    return cards;
  }

  Map<User, Widget> getUsersCardByTheme(User user, Map<User, double> usersSuggestion) {

    if (usersSuggestion == null) return null;

    Map<User, Card> cards = new Map<User, Card>();

    usersSuggestion.forEach((userSuggestion, distance) {

      if (user.email != userSuggestion.email) {
        this.tags.forEach((tag) {
          if (tag.isActive) {
            tag.googleType.forEach((type) {
              if (userSuggestion.favoriteThemes.contains(type)) {
                cards.putIfAbsent(userSuggestion, () => Card(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(userSuggestion.firstName + " " + userSuggestion.lastName),
                        Text(distance.toString() + "m")
                      ],
                    ),
                  ),
                ));
              }
            });
          }
        });
      }
    });

    return cards;
  }

  Map<User, Widget> getUsersCardByName(User user, Map<User, double> usersSuggestion) {

    if (usersSuggestion == null) return null;
    Map<User, Card> cards = new Map<User, Card>();

    usersSuggestion.forEach((userSuggestion, distance) {
      if (user.email != userSuggestion.email) {
        cards.putIfAbsent(userSuggestion, () => _getUserCard(userSuggestion, distance));
      }
    });

    return cards;
  }

  Card _getUserCard(User userSuggestion, double distance) {

    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(userSuggestion.firstName + " " + userSuggestion.lastName),
            Text(distance.toString() + "m")
          ],
        ),
      ),
    );
  }
}