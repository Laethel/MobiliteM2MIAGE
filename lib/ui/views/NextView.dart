import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:provider/provider.dart';

class NextPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return NextPageState();
  }
}

class NextPageState extends State<NextPage> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(authProvider.user.email),
      ),
    );
  }
}