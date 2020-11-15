import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';
import 'package:mobilitem2miage/ui/views/AccountView.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:mobilitem2miage/ui/views/LoginView.dart';
import 'package:mobilitem2miage/ui/views/MapView.dart';
import 'package:mobilitem2miage/ui/views/PlaceView.dart';

class HomeModel extends BaseModel {

  AuthService authProvider = AuthService();
  int currentIndex = 0;

  List<Widget> getChildrens() {

    List<Widget> childrens = [
      MapView(),
      PlaceView(),
      AccountView()
    ];

    return childrens;
  }

  void onTappedBar(int index) {

    currentIndex = index;
    notifyListeners();
  }
}