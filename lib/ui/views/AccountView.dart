import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/viewmodels/AccountModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AccountViewState();
  }
}

class AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {

    var authProvider = Provider.of<AuthService>(context);

    return BaseView<AccountModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(authProvider.user.email),
                IconButton(
                  icon: Icon(FontAwesomeIcons.signOutAlt),
                  onPressed: () {
                    authProvider.signOut();
                    Navigator.pushNamed(context, '/login');
                  },
                )
              ],
            ),
          )
        );
      },
    );
  }
}