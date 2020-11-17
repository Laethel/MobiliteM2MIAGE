import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {

  String id;
  String lastName;
  String firstName;
  String email;
  String gender;
  Timestamp birthday;
  Timestamp createdOn;

  User({this.id, @required this.lastName, @required this.firstName, @required this.email, @required this.birthday, this.createdOn, this.gender});

  /// Used by SharedPreferencesService to serialize/deserialize User object
  User.fromJson(Map snapshot) :
        id = snapshot['id'] ?? '',
        lastName = snapshot['lastName'] ?? '',
        firstName = snapshot['firstName'] ?? '',
        email = snapshot['email'] ?? '',
        birthday = Timestamp.fromMillisecondsSinceEpoch(int.parse(snapshot['birthday']) * 1000) ?? '',
        createdOn = Timestamp.fromMillisecondsSinceEpoch(int.parse(snapshot['createdOn']) * 1000) ?? '',
        gender = snapshot['gender'] ?? '';

  toJson() {

    return {
      "id": id,
      "lastName": lastName,
      "firstName": firstName,
      "email": email,
      "birthday": birthday.seconds.toString(),
      "createdOn": createdOn.seconds.toString(),
      "gender": gender
    };
  }
}