import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilitem2miage/core/enum/ViewState.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/utils/DateUtils.dart';
import 'package:mobilitem2miage/core/viewmodels/UserProfilModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:mobilitem2miage/ui/widgets/WTextField.dart';

class UserProfilView extends StatefulWidget {

  User user;
  UserProfilView({@required this.user});

  @override
  State<StatefulWidget> createState() {
    return UserProfilViewState();
  }
}

class UserProfilViewState extends State<UserProfilView> {

  @override
  Widget build(BuildContext context) {

    return BaseView<UserProfilModel>(
      onModelReady: (model) async {

      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF809cc5),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.clear),
              )
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(Colors.red.withOpacity(0.1), BlendMode.dstATop),
                image: AssetImage("res/assets/img/passport.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Passeport",
                        style: GoogleFonts.roboto(
                          fontSize: 26.0
                        ),
                      ),
                    ],
                  ),

                  Text(
                    "Passport",
                    style: GoogleFonts.roboto(
                        fontSize: 18.0
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      model.state == ViewState.Idle ? Container(
                        child: Container(
                          width: 180.0,
                          height: 180.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("res/assets/img/macron.jpg")
                            ),
                            border: Border.all(
                              color: Color(0xFF809cc5),
                              width: 2.0
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          )
                        ),
                      )
                      /*Image.memory(
                        model.imageBytes,
                        height: 260,
                        width: 180,
                        fit: BoxFit.cover,
                      )*/ : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF809cc5),
                        ),
                        height: 180,
                        width: 180,
                        child: CircularProgressIndicator(),
                      ),

                      SizedBox(height: 20.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Nom", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                                    Text("/", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                                    Text("Lastname", style: GoogleFonts.roboto(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Container(
                                  width: 110.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: WTextField(
                                      value: widget.user.lastName,
                                      enable: false,
                                      controller: TextEditingController(),
                                      fontSize: 14.0,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Prénom", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                                    Text("/", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                                    Text("Firstname", style: GoogleFonts.roboto(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Container(
                                  width: 150.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: WTextField(
                                      value: widget.user.firstName,
                                      enable: false,
                                      controller: TextEditingController(),
                                      fontSize: 14.0,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Date de Naissance", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                                Container(
                                  width: 150.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: WTextField(
                                      value: DateUtils.dateToString(DateTime.fromMillisecondsSinceEpoch(widget.user.birthday.millisecondsSinceEpoch)),
                                      enable: false,
                                      controller: TextEditingController(),
                                      fontSize: 14.0,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Nationalité", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                                Container(
                                  width: 80.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: WTextField(
                                      value: "FR",
                                      enable: false,
                                      controller: TextEditingController(),
                                      fontSize: 14.0,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Sexe", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                                Container(
                                  width: 80.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: WTextField(
                                      value: widget.user.gender,
                                      enable: false,
                                      controller: TextEditingController(),
                                      fontSize: 14.0,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}