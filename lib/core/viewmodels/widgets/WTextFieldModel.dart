import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';

class WTextFieldModel extends BaseModel {

  FocusNode mailFocusNode = FocusNode();
  TextEditingController mail = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  TextEditingController password = TextEditingController();
}