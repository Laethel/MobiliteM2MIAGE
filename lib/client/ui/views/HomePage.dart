import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobilitem2miage/client/services/AuthManager.dart';
import 'package:mobilitem2miage/client/services/HashService.dart';
import 'package:mobilitem2miage/client/ui/views/LoginPage.dart';
import 'package:mobilitem2miage/client/ui/views/NextPage.dart';
import 'package:mobilitem2miage/server/ConfigManager.dart';
import 'package:mobilitem2miage/server/FireStoreManager.dart';
import 'package:mobilitem2miage/server/model/Event.dart';
import 'package:mobilitem2miage/server/model/Response.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  String _message = "Nothing";
  ConfigManager manager = ConfigManager();
  AuthManager auth = AuthManager();
  FireStoreManager store = FireStoreManager();

  @override
  void reassemble() async {

    String res = (await this.auth.isLogged) ? this.auth.user.email : "Déconnecté";
    setState(() {
      _message = res;
    });

    super.reassemble();
  }

  @override
  void initState() {

    /// Analytics : Application is open
    this.manager.eventAppOpen();
    super.initState();
  }

  void changeMessage(String message) {

    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text("Go to Login page"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            ),
            MaterialButton(
                child: Text("Logout"),
                onPressed: () {
                  auth.signOut();
                  setState(() {
                    _message = "Déconnecté";
                  });
                }
            ),
            MaterialButton(
                child: const Text('Test logEvent'),
                onPressed: () async {
                  String result = await this.manager.sendAnalyticsEvent(
                      Event(
                        name: "test_event",
                        parameters: <String, dynamic>{
                          'string': 'roger cela',
                          'int': 42,
                        },
                        result: "Résultat de l'event !"
                      )
                  );

                  changeMessage(result);
                }
            ),
            MaterialButton(
                child: const Text('Create Record'),
                onPressed: () {
                  this.store.createRecord();
                }
            ),
            Text(_message)
          ],
        )
      ),
    );
  }
}