import 'package:firebase_analytics/firebase_analytics.dart';
import 'dart:async';

import 'package:firebase_analytics/observer.dart';
import 'package:mobilitem2miage/core/models/server/Event.dart';

class AnalyticsService  {

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  Future<String> sendAnalyticsEvent(Event event) async {

    await AnalyticsService.analytics.logEvent(
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

  void eventAppOpen() {
    AnalyticsService.analytics.logAppOpen().whenComplete(() => {

      print("[Analytics] GOOD : " + "AppOpenEvent sent successfully.")

    }).catchError((error) {

      print("[Analytics] ERROR : " + "AppOpenEvent not sent because of :\n " + error);
    });
  }
}