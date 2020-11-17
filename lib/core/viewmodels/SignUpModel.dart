import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/models/server/Response.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/viewmodels/BaseModel.dart';

class SignUpModel extends BaseModel {

  String messageError = "";
  AuthService auth = AuthService();
  TextEditingController mail = TextEditingController();
  TextEditingController mailConfirm = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  String gender;
  Timestamp birthday;
  String birthdayString = "Date de naissance";

  Response isFormValid() {

    if (this.password.text != this.passwordConfirm.text) {
      return new Response(RESPONSE_TYPE.ERROR, "passwordConfirmError");
    } else if (this.name.text == "" || this.firstName.text == "") {
      return new Response(RESPONSE_TYPE.ERROR, "nameError");
    } else if (this.mail.text != this.mailConfirm.text) {
      return new Response(RESPONSE_TYPE.ERROR, "emailConfirmError");
    } else if (this.gender == null) {
      return new Response(RESPONSE_TYPE.ERROR, "genderError");
    } else if (this.birthday == null) {
      return new Response(RESPONSE_TYPE.ERROR, "dateError");
    }

    return null;
  }

  String getMessageError() {

    switch(messageError) {
      case "The email address is badly formatted.":
        return "Veuillez renseigner une adresse mail valide.";
        break;
      case "Password should be at least 6 characters":
        return "Le mot de passe doit faire plus de 6 caractères.";
      case "Given String is empty or null":
        return "Veuillez renseigner une adresse mail et un mot de passe.";
        break;
      case "emailConfirmError":
        return "Les adresse mail ne correspondent pas. Veuillez réessayer.";
      case "passwordConfirmError":
        return "Les mots de passe ne correspondent pas. Veuillez réessayer.";
      case "nameError":
        return "Veuillez renseignez un nom et un prénom.";
      case "genderError":
        return "Veuillez renseignez un genre.";
      case "dateError":
        return "Veuillez renseignez une date de naissance.";
      default:
        return messageError;
    }
  }

  void selectGender(String gender) {

    this.gender = gender;
    this.notifyListeners();
  }

  Future<void> selectBirthday(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != this.birthday) {
      this.birthday = Timestamp.fromDate(picked);
      this.birthdayString = picked.day.toString() + "/" + picked.month.toString() + "/" + picked.year.toString();
      this.notifyListeners();
    }
  }
}