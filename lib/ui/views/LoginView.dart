import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/viewmodels/LoginModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:mobilitem2miage/ui/views/Next2View.dart';
import 'package:provider/provider.dart';
import 'NextView.dart';
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
    var userProvider = Provider.of<UserDao>(context);
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                        Text(" Se connecter 1")
                      ],
                    ),
                    onTap: () async {
                      Response response = await model.auth.emailSignUp(User(mail: model.mail.text, name: "Andréa", firstName: "Christophe"), model.password.text);
                      if (response.type == RESPONSE_TYPE.VALIDE) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Next2Page()),
                        );
                      } else {
                        setState(() {
                          model.message = response.description;
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
                      /*
                      if (response.isNewUser) {
                        userProvider.add(
                            User(
                                name: model.auth.user.displayName.split(" ")[1],
                                firstName: model.auth.user.displayName.split(" ")[0],
                                mail: model.auth.user.email
                            )
                        );
                      }
                      */
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage()),
                      );
                    },
                  )
              ),
            ),

            MaterialButton(
              child: Text("Create User"),
              onPressed: () async {
/*
                userProvider.add(
                  User(
                    id: "1",
                    name: "Andréa",
                    firstName: "Christophe",
                    mail: "andrea.christophe@gmail.com"
                  )
                );


                List<User> users = await userProvider.fetch();

                for(int i=0; i<users.length; i++) {

                  print("User N°" + i.toString() + " - " + users[i].name + " - " + users[i].id);
                }
                */

                //await userProvider.remove("qcZkyxLeZ1yu5JYMVXvc");

                User user = await userProvider.getById("P9x6J2WQDZZHwWY4qyFg");
                user.mail = "cacahuete@gmail.com";

                await userProvider.update(
                  user,
                  "P9x6J2WQDZZHwWY4qyFg"
                );

              },
            ),

            Text(model.message)

          ],
        ),
      )
    );
  }
}