import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/models/client/Post.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';
import 'package:mobilitem2miage/ui/views/PlaceDetailsPostsView.dart';

class PlaceDetailsPostsModel extends BaseModel {

  List<Post> posts = new List<Post>();
  TextEditingController newPost = new TextEditingController();

  String getFormatedPostDate(DateTime date) {

    DateTime now = DateTime.now();
    if (now.difference(date).inDays == 0) {
      if (now.difference(date).inHours == 0) {
        if (now.difference(date).inMinutes == 0) {
          if (now.difference(date).inSeconds == 0) {

          } else {
            return now.difference(date).inSeconds.toString() + " s";
          }
        } else {
          return now.difference(date).inMinutes.toString() + " m";
        }
      } else {
        return now.difference(date).inHours.toString() + " h";
      }
    } else {
      return now.difference(date).inDays.toString() + " j";
    }

    return "À l'instant";
  }

  Future<bool> alertDialog(BuildContext context) async {

    bool res = false;
    print("Ok : " + res.toString());

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Suppression"),
          content: Text("Voulez-vous vraiment supprimer cet avis ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Annuler"),
              onPressed: () {
                Navigator.pop(context);
                res = false;
              },
            ),
            FlatButton(
              child: Text("Oui"),
              onPressed: () {
                Navigator.pop(context);
                res = true;
              },
            )
          ],
        );
      },
    );

    print("Ok : " + res.toString());
    return res;
  }
}