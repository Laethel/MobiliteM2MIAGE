import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'package:mobilitem2miage/core/viewmodels/LoginModel.dart';
import 'package:mobilitem2miage/core/viewmodels/SignUpModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:mobilitem2miage/core/models/server/Response.dart';
import 'package:mobilitem2miage/ui/widgets/WTextField.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return SignUpViewState();
  }
}

class SignUpViewState extends State<SignUpView> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var appState = Provider.of<AppState>(context);

    return BaseView<SignUpModel>(
      builder: (context, model, child) =>  Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFF809cc5),
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
              image: AssetImage("res/assets/img/loginBackground.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent,
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppBar(
                    title: Text("Se connecter"),
                    backgroundColor: Colors.transparent,
                    elevation: 0.0
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    children: [

                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0),
                        child: Column(
                          children: [

                            Container(
                              color: Colors.white54,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                child: WTextField(
                                  label: "Adresse mail",
                                  controller: model.mail,
                                  suffixIcon: Icon(Icons.email),
                                ),
                              ),
                            ),

                            Container(
                              color: Colors.white54,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                child: WTextField(
                                  label: "Confirmer",
                                  controller: model.mailConfirm,
                                ),
                              ),
                            ),

                            SizedBox(height: 10.0),

                            Container(
                              color: Colors.white54,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: WTextField(
                                    label: "Nom",
                                    controller: model.name,
                                    suffixIcon: Icon(Icons.person),
                                    obscureText: false,
                                  )
                              ),
                            ),

                            Container(
                              color: Colors.white54,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: WTextField(
                                    label: "Prénom",
                                    controller: model.firstName,
                                    obscureText: false,
                                  )
                              ),
                            ),

                            SizedBox(height: 10.0),

                            Container(
                              color: Colors.white54,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: WTextField(
                                    label: "Mot de passe",
                                    controller: model.password,
                                    suffixIcon: Icon(Icons.lock),
                                    obscureText: true,
                                  )
                              ),
                            ),

                            Container(
                              color: Colors.white54,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: WTextField(
                                    label: "Confirmer",
                                    controller: model.passwordConfirm,
                                    obscureText: true,
                                  )
                              ),
                            ),

                            SizedBox(height: 10.0),

                            Container(
                              height: 60.0,
                              color: Colors.white54,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async => await model.selectBirthday(context),
                                        child: Row(
                                          children: [
                                            Icon(Icons.cake),
                                            SizedBox(width: 5.0),
                                            Text(
                                              model.birthdayString,
                                              style: GoogleFonts.roboto(
                                                fontSize: 16.0
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            color: model.gender == "M" ? Colors.black54 : Colors.white54,
                                            child: IconButton(
                                              onPressed: () => model.selectGender("M"),
                                              icon: Icon(
                                                FontAwesomeIcons.mars,
                                                color: model.gender == "M" ? Colors.white : Colors.black,
                                              )
                                            ),
                                          ),
                                          SizedBox(width: 5.0),
                                          Container(
                                            color: model.gender == "F" ? Colors.black54 : Colors.white54,
                                            child: IconButton(
                                              onPressed: () => model.selectGender("F"),
                                              icon: Icon(
                                                FontAwesomeIcons.venus,
                                                color: model.gender == "F" ? Colors.white : Colors.black,
                                              )
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                              ),
                            ),

                          ],
                        ),
                      ),

                      Text(
                        model.getMessageError(),
                        style: GoogleFonts.roboto(
                            fontSize: 16.0,
                            color: Colors.redAccent
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(80.0),
                      elevation: 5.0,
                      child: Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              border: Border.all(style: BorderStyle.solid, color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(80.0))
                          ),
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Valider",
                                  style: GoogleFonts.roboto(
                                      fontSize: 16.0,
                                      color: Colors.white
                                  ),
                                )
                              ],
                            ),
                            onTap: () async {

                              Response res;

                              /// If form doens't match response with error
                              res = model.isFormValid();

                              /// If email and password match, try signUp
                              if (res == null) {

                                res = await model.auth.emailSignUp(
                                    new User(
                                      email: model.mail.value.text,
                                      firstName: model.firstName.value.text,
                                      lastName: model.name.value.text,
                                      birthday: model.birthday,
                                      gender: model.gender
                                    ),
                                    model.password.value.text
                                );
                              }

                              /// If signUp is valide, login and go to homeview
                              if (res.type == RESPONSE_TYPE.VALIDE) {
                                appState.user = res.value;
                                Navigator.pushNamed(context, '/home');
                              } else {
                                model.messageError = res.value;
                                model.notifyListeners();
                              }
                            },
                          )
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}