import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/viewmodels/LoginModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:mobilitem2miage/core/models/server/Response.dart';

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

    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login"),

              TextField(
                controller: model.mail,
              ),

              TextField(
                controller: model.password,
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 90,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey
                    ),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email),
                          Text(" S'inscrire")
                        ],
                      ),
                      onTap: () async {

                        Response response = await model.auth.emailSignUp(
                          User(
                            mail: model.mail.text,
                            name: "Andréa",
                            firstName: "Christophe"
                          ), model.password.text
                        );

                        if (response.type == RESPONSE_TYPE.VALIDE) {
                          Navigator.pushNamed(context, '/home');
                        } else {
                          setState(() {
                            model.messageError = response.description;
                          });
                        }
                      },
                    )
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 90,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey
                    ),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email),
                          Text(" Se connecter")
                        ],
                      ),
                      onTap: () async {

                        Response response = await model.auth.emailSignIn(model.mail.value.text, model.password.value.text);

                        if (response.type == RESPONSE_TYPE.VALIDE) {
                          Navigator.pushNamed(context, '/home');
                        } else {
                          setState(() {
                            model.messageError = response.description;
                          });
                        }
                      },
                    )
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 90,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.redAccent
                    ),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email),
                          Text(" Google")
                        ],
                      ),
                      onTap: () async {
                        Response response = await model.auth.googleSignIn();
                        if (response.type == RESPONSE_TYPE.VALIDE) {
                            Navigator.pushNamed(context, '/home');
                        } else {
                          setState(() {
                            model.messageError = response.description;
                          });
                        }
                      },
                    )
                ),
              ),

              Text(model.messageError)

            ],
          ),
        ),
      )
    );
  }
}