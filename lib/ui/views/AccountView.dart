import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/services/SharedPreferencesService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/viewmodels/AccountModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AccountViewState();
  }
}

class AccountViewState extends State<AccountView> {

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserDao>(context);
    var authProvider = Provider.of<AuthService>(context);
    var preferencesProvider = Provider.of<SharedPreferencesService>(context);

    return BaseView<AccountModel>(
      onModelReady: (model) async {
        /// Initialize SharedPreferences to add user to it
        model.user = User.fromJson(await preferencesProvider.read("user"));
        model.notifyListeners();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Passeport",
                      style: GoogleFonts.roboto(
                        fontSize: 26.0
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => print("Recherche profils"),
                          icon: Icon(Icons.search),
                        ),
                        IconButton(
                          onPressed: () => print("Recherche profils"),
                          icon: Icon(Icons.message),
                        ),
                      ],
                    )
                  ],
                ),

                Text(
                  "Passport",
                  style: GoogleFonts.roboto(
                      fontSize: 18.0
                  ),
                ),

                SizedBox(height: 20.0),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 5.0,
                      child: Image.network(
                        "https://file1.closermag.fr/var/closermag/storage/images/bio-people/biographie-emmanuel-macron-389948/3299342-2-fre-FR/Emmanuel-Macron.jpg?alias=square500x500&size=x100&format=jpeg",
                        width: 180,
                        height: 260,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Nom"),
                              Text("/"),
                              Text("Lastname", style: GoogleFonts.roboto(fontStyle: FontStyle.italic)),
                            ],
                          ),
                          model.user != null ? Text(model.user.lastName) : CircularProgressIndicator(),

                          SizedBox(height: 10.0),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Prénom"),
                                  Text("/"),
                                  Text("Firstname", style: GoogleFonts.roboto(fontStyle: FontStyle.italic)),
                                ],
                              ),
                              model.user != null ? Text(model.user.firstName) : CircularProgressIndicator()
                            ],
                          ),

                          SizedBox(height: 10.0),

                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Nationalité"),
                                  model.user != null ? Text("Française") : CircularProgressIndicator()
                                ],
                              ),

                              SizedBox(width: 40.0),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Sexe"),
                                  model.user != null ? Text(model.user.gender) : CircularProgressIndicator()
                                ],
                              )
                            ],
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              authProvider.signOut();
              /// TODO : Penser à reset le user dans SharedPreferences
              Navigator.pushNamed(context, '/login');
            },
            child: Icon(FontAwesomeIcons.signOutAlt),
          ),
        );
      },
    );
  }
}