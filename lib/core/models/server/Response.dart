import 'package:firebase_auth/firebase_auth.dart';

enum RESPONSE_TYPE {
  VALIDE,
  ERROR
}

class Response {

  RESPONSE_TYPE type;
  String description;
  bool isNewUser;

  Response(this.type, this.description);
}