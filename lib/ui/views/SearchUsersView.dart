import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
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

    var userDaoProvider = Provider.of<UserDao>(context);

    return BaseView<SearchUsersModel>(
      onModelReady: (model) {
        model.searchBar = new SearchBar(
          hintText: "Rechercher un utilisateur",
          inBar: false,
          setState: setState,
          onSubmitted: model.onSubmitted,
          buildDefaultAppBar: model.buildAppBar
        );
      },
      builder: (context, model, child) => Scaffold(
        appBar: model.searchBar.build(context),
        body: model.users != null && model.users.isNotEmpty ? ListView.builder(
            itemCount: model.users.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/userProfil", arguments: model.users[index]);
                  },
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(model.users[index].firstName + " " + model.users[index].lastName),
                    ),
                  ),
                )
              );
            }
        ) : Center(child: Text("Aucun utilisateur trouvé"))
      )
    );
  }
}