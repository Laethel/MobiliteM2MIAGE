import 'package:flutter/material.dart';
import 'package:mobilitem2miage/client/ui/views/HomePage.dart';
import 'package:mobilitem2miage/server/ConfigManager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorObservers: <NavigatorObserver>[ConfigManager.observer],
      home: HomePage(),
    );
  }
}