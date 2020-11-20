import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobilitem2miage/core/services/RemoveBgService.dart';
import 'package:mobilitem2miage/core/viewmodels/HomeModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';

class HomeView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      builder: (context, model, child) {
        return Scaffold(
          key: GlobalKey(),
          body: model.getChildrens()[model.currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF809cc5),
                  offset: Offset(0.0, -1.0),
                )
              ],
              color: Colors.white,
            ),
            child: BottomNavigationBar(
              backgroundColor: Color(0xFF809cc5),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.white,
              selectedItemColor: Color(0xFF50627b),
              onTap: (int) {
                model.onTappedBar(int);
              },
              currentIndex: model.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.mapMarked, size: 20.0),
                  title: Text("Carte"),
                ),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.atlas, size: 20.0),
                    title: Text("Lieu")
                ),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.solidUser, size: 20.0),
                    title: Text("Compte")
                ),
              ],
            ),
          )
        );
      },
    );
  }
}