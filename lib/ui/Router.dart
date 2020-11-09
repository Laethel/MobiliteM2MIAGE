import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobilitem2miage/ui/views/HomeView.dart';
import 'package:mobilitem2miage/ui/views/LoginView.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return  MaterialPageRoute(
            builder: (_)=> HomeView()
        );
      case '/login' :
        return MaterialPageRoute(
            builder: (_)=> LoginView()
        ) ;
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