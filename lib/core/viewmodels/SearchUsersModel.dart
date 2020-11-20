import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mobilitem2miage/core/enum/ViewState.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';

class SearchUsersModel extends BaseModel {

  TextEditingController searchController = new TextEditingController();
  SearchBar searchBar;
  UserDao userDao = new UserDao();
  List<User> users = new List<User>();

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: this.users == null || this.users.isEmpty ? Text("Recherche") : Text(this.users.length.toString() + " utilisateur" + (this.users.length == 1 ? "" : "(s)") + " trouvé" + (this.users.length == 1 ? "" : "(s)")),
      backgroundColor: Color(0xFF809cc5),
      actions: [searchBar.getSearchAction(context)]
    );
  }

  void onSubmitted(String value) async {

    this.users.clear();
    if (value == "") return null;

    await this.userDao.fetch().then((users) {
      setState(ViewState.Busy);
      users.forEach((user) {
        if (user.lastName.toLowerCase().contains(value.toLowerCase()) || user.firstName.toLowerCase().contains(value.toLowerCase())) {
          this.users.add(user);
        }
      });
    });
    setState(ViewState.Idle);
  }
}