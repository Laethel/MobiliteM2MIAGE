import 'package:flutter/cupertino.dart';

class Event {

  /// Name must consist of letters, digits or _ (underscores). Exemple : test_exemple
  String name;
  Map<String, dynamic> parameters;
  String result;

  Event({@required String name, Map<String, dynamic> parameters, String result}) {

    this.name = name;
    this.parameters = parameters;
    this.result = result;
  }
}