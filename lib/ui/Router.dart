import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobilitem2miage/ui/views/AccountView.dart';
import 'package:mobilitem2miage/ui/views/HomeView.dart';
import 'package:mobilitem2miage/ui/views/MapView.dart';
import 'package:mobilitem2miage/ui/views/LoginView.dart';
import 'package:mobilitem2miage/ui/views/PlaceView.dart';
import 'package:mobilitem2miage/ui/views/SignUpView.dart';

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
      case '/account' :
        return MaterialPageRoute(
            builder: (_)=> AccountView()
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