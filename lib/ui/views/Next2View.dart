import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:provider/provider.dart';

class Next2Page extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return Next2PageState();
  }
}

class Next2PageState extends State<Next2Page> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Sign up OK"),
      ),
    );
  }
}