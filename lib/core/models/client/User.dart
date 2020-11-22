import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable(explicitToJson: true)
class User {

  String id;

  String lastName;

  String firstName;

  String email;

  String gender;

  DateTime birthday;

  DateTime createdOn;

  String location;

  List<String> favoriteThemes;

  User({this.id, @required this.lastName, @required this.firstName, @required this.email, @required this.birthday, this.createdOn, this.gender, this.location, this.favoriteThemes});

  factory User.fromJson(Map<String,dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}