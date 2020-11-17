import 'package:flutter/cupertino.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';

class LoginModel extends BaseModel {

  String messageError = "";
  AuthService auth = AuthService();

  FocusNode mailFocusNode = FocusNode();
  TextEditingController mail = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  TextEditingController password = TextEditingController();

  String getMessageError() {

    switch(messageError) {
      case "The password is invalid or the user does not have a password.":
        return "Le mot de passe est invalide ou l'utilisateur n'existe pas.";
        break;
      case "There is no user record corresponding to this identifier. The user may have been deleted.":
        return "Aucun compte n'est associé à cette adresse mail.";
        break;
      case "Given String is empty or null":
        return "Veuillez renseigner une adresse mail et un mot de passe valide.";
        break;
      default:
        return messageError;
    }
  }
}