import 'package:flutter/material.dart';

class Tag {

  String label;
  List<String> googleType;
  IconData icon;
  bool isActive;

  Tag({@required this.label, @required this.googleType, @required this.icon, this.isActive});
}