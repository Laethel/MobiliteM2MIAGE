import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilitem2miage/core/enum/ViewState.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'package:mobilitem2miage/core/viewmodels/LoginModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:mobilitem2miage/core/models/server/Response.dart';
import 'package:mobilitem2miage/ui/widgets/WTextField.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var appState = Provider.of<AppState>(context);

    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF809cc5),
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: AssetImage("res/assets/img/loginBackground.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(30.0),
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
                    Column(
                      children: [
                        Image.asset(
                          "res/assets/img/appLogo.png",
                          width: 150.0,
                          height: 150.0
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0),
                          child: Column(
                            children: [

                              Container(
                                color: Colors.white54,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: WTextField(
                                    label: "Identifiant",
                                    controller: model.mail,
                                    suffixIcon: Icon(Icons.email),
                                  ),
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
                                      "Se connecter",
                                      style: GoogleFonts.roboto(
                                          fontSize: 16.0,
                                          color: Colors.white
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () async {
                                  model.setState(ViewState.Busy);
                                  Response response = await model.auth.emailSignIn(model.mail.value.text, model.password.value.text);
                                  model.setState(ViewState.Idle);

                                  if (response.type == RESPONSE_TYPE.VALIDE) {
                                    appState.user = response.value;
                                    Navigator.pushNamed(context, '/home');
                                  } else {
                                    model.messageError = response.value;
                                    model.notifyListeners();
                                  }
                                },
                              )
                          ),
                        ),

                        SizedBox(height: 20.0),

                        Material(
                          borderRadius: BorderRadius.circular(80.0),
                          elevation: 5.0,
                          child: Container(
                              height: 60,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(style: BorderStyle.solid, color: Colors.transparent),
                                  borderRadius: BorderRadius.all(Radius.circular(80.0))
                              ),
                              child: InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("res/assets/img/google-logo.png", height: 40.0, width: 40.0),
                                    SizedBox(width: 10.0),
                                    Text(
                                      "Se connecter avec Google",
                                      style: GoogleFonts.roboto(
                                          fontSize: 16.0,
                                          color: Color(0xFF333333)
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () async {
                                  model.setState(ViewState.Busy);
                                  Response response = await model.auth.googleSignIn();
                                  if (response.type == RESPONSE_TYPE.VALIDE) {
                                    appState.user = response.value;
                                    Navigator.pushNamed(context, '/home');
                                  } else {
                                    setState(() {
                                      model.messageError = response.value;
                                    });
                                  }
                                  model.setState(ViewState.Idle);
                                },
                              )
                          ),
                        ),

                        Container(
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.transparent
                            ),
                            child: InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Pas encore de compte ?",
                                      style: GoogleFonts.roboto(
                                          color: Color(0xFFEEEEEE),
                                          fontSize: 16.0
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () => Navigator.pushNamed(context, '/signUp')
                            )
                        ),
                      ],
                    )
                  ],
                ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              /// If place are loading, display a CircularProgressIndicator with a waiting message
              child: model.state == ViewState.Busy ? Stack(
                alignment: Alignment.center,
                children: [
                  /// When places are loading, the user's screen is blocked
                  Container(height: 1000, width: 1000, color: Colors.transparent),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20.0),
                      Text(
                          "Veuillez patientez...",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          )
                      )
                    ],
                  )
                ],
              ) : SizedBox.shrink(),
            ),
          ],
        ),
      )
    );
  }
}