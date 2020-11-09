import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/models/server/Event.dart';
import 'package:mobilitem2miage/core/services/AnalyticsService.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';

class HomeView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {

  String _message = "Nothing";
  AnalyticsService manager = AnalyticsService();
  AuthService auth = AuthService();

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
                Navigator.pushNamed(context, '/login');
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
            Text(_message)
          ],
        )
      ),
    );
  }
}