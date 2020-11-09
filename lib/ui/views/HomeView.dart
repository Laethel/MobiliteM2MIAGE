import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/models/server/Event.dart';
import 'package:mobilitem2miage/core/services/AnalyticsService.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';

class HomeView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text("HomePage"),
      )
    );
  }
}