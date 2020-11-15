import 'package:flutter/cupertino.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';

class LoginModel extends BaseModel {

  String messageError = "";
  AuthService auth = AuthService();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
}