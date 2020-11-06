import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text("HomePage"),
      ),
    );
  }
}