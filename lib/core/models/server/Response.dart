import 'package:mobilitem2miage/core/models/client/User.dart';

enum RESPONSE_TYPE {
  VALIDE,
  ERROR
}

class Response<T> {

  RESPONSE_TYPE type;
  bool isNewUser;
  T value;

  Response(this.type, this.value);
}