import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/viewmodels/PlaceModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';

class PlaceView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return PlaceViewState();
  }
}

class PlaceViewState extends State<PlaceView> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PlaceModel>(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text("Place View"),
        )
      )
    );
  }
}