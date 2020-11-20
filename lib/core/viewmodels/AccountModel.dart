import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';

class AccountModel extends BaseModel {

  Uint8List imageBytes;

  void alertDialog(BuildContext context, AuthService authProvider) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Se déconnecter"),
          content: Text("Voulez-vous vraiment vous déconnecter ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Oui"),
              onPressed: () {
                authProvider.signOut();
                /// TODO : Penser à reset le user dans SharedPreferences
                Navigator.pushNamed(context, '/login');
              },
            )
          ],
        );
      },
    );
  }
}