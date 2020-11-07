import 'package:flutter/material.dart';
import 'package:mobilitem2miage/server/ConfigManager.dart';
import 'package:mobilitem2miage/server/model/Event.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  String _message = "Nothing";
  ConfigManager manager = ConfigManager();

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