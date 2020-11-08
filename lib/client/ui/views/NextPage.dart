import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilitem2miage/client/services/AuthManager.dart';

class NextPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return NextPageState();
  }
}

class NextPageState extends State<NextPage> {

  AuthManager auth = AuthManager();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(this.auth.user.email),
      ),
    );
  }
}