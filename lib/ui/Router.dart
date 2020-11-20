import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/ui/views/AccountView.dart';
import 'package:mobilitem2miage/ui/views/HomeView.dart';
import 'package:mobilitem2miage/ui/views/MapView.dart';
import 'package:mobilitem2miage/ui/views/LoginView.dart';
import 'package:mobilitem2miage/ui/views/PlaceDetailsView.dart';
import 'package:mobilitem2miage/ui/views/PlaceView.dart';
import 'package:mobilitem2miage/ui/views/SearchUsersView.dart';
import 'package:mobilitem2miage/ui/views/SignUpView.dart';
import 'package:mobilitem2miage/ui/views/UserProfilView.dart';
import 'package:google_maps_webservice/places.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home' :
        return  MaterialPageRoute(
            builder: (_)=> HomeView()
        );
      case '/map' :
        return  MaterialPageRoute(
            builder: (_)=> MapView()
        );
      case '/login' :
        return MaterialPageRoute(
            builder: (_)=> LoginView()
        );
      case '/signUp' :
        return MaterialPageRoute(
            builder: (_)=> SignUpView()
        );
      case '/place' :
        return MaterialPageRoute(
            builder: (_)=> PlaceView()
        );
      case '/placeDetails' :
        var place = settings.arguments as PlaceDetails;
        return MaterialPageRoute(
            builder: (_)=> PlaceDetailsView(place: place)
        );
      case '/account' :
        return MaterialPageRoute(
            builder: (_)=> AccountView()
        );
      case '/search' :
        return MaterialPageRoute(
            builder: (_)=> SearchUsersView()
        );
      case '/userProfil' :
        var user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_)=> UserProfilView(user: user)
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('Error 404 : route not found'),
              ),
            )
        );
    }
  }
}