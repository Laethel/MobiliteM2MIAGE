import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilitem2miage/client/services/AuthManager.dart';
import 'package:mobilitem2miage/client/ui/views/NextPage.dart';
import 'package:mobilitem2miage/server/model/Response.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {

  String message = "";
  AuthManager auth = AuthManager();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: this.mail,
          ),

          TextField(
            controller: this.password,
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
                    Response response = await this.auth.emailSignIn(this.mail.text, this.password.text);
                    if (response.type == RESPONSE_TYPE.VALIDE) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage()),
                      );
                    } else {
                      setState(() {
                        message = response.description;
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
                onTap: () {
                  this.auth.googleSignIn().whenComplete(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NextPage()),
                    );
                  });
                },
              )
            ),
          ),

          Text(message)

        ],
      ),
    );
  }
}