import 'package:firebase_analytics/firebase_analytics.dart';
import 'dart:async';

import 'package:firebase_analytics/observer.dart';
import 'package:mobilitem2miage/server/IConfigManager.dart';
import 'package:mobilitem2miage/server/model/Event.dart';

class ConfigManager implements IConfigManager {

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Future<String> sendAnalyticsEvent(Event event) async {

    await ConfigManager.analytics.logEvent(
      name: event.name,
      parameters: event.parameters,
    ).whenComplete(() => {

      /// TODO : Créer une classe de LOG pour les messages post Event
      print("[Analytics] GOOD : " + event.name + " sent successfully.")

    }).catchError((error) {

      print("[Analytics] ERROR : " + event.name + " not sent because of :\n " + error);
    });
    return event.result;
  }

  @override
  void eventAppOpen() {
    ConfigManager.analytics.logAppOpen().whenComplete(() => {

      print("[Analytics] GOOD : " + "AppOpenEvent sent successfully.")

    }).catchError((error) {

      print("[Analytics] ERROR : " + "AppOpenEvent not sent because of :\n " + error);
    });
  }
}