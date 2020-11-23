import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilitem2miage/core/models/client/User.dart';
import 'package:mobilitem2miage/core/viewmodels/LoginModel.dart';
import 'package:mobilitem2miage/core/viewmodels/SignUpModel.dart';
import 'package:mobilitem2miage/core/viewmodels/widgets/WTextFieldModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:mobilitem2miage/core/models/server/Response.dart';

class WTextField extends StatefulWidget {

  String value;
  String label;
  TextEditingController controller;
  Widget suffixIcon;
  bool obscureText;
  bool enable;
  double fontSize;
  TextAlign textAlign;

  WTextField({@required this.value, this.label, @required this.controller, this.suffixIcon, this.obscureText, this.enable, this.fontSize, this.textAlign});

  @override
  State<StatefulWidget> createState() {

    return WTextFieldState();
  }
}

class WTextFieldState extends State<WTextField> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BaseView<WTextFieldModel>(
      builder: (context, model, child) => Theme(
        data: ThemeData(
          primaryColor: Color(0xFF50627b),
          accentColor: Colors.orange,
          hintColor: Color(0xFF333333)
        ),
        child: TextField(
          enabled: widget.enable,
          textAlign: widget.textAlign != null ? widget.textAlign : TextAlign.start,
          style: GoogleFonts.roboto(
            fontSize: widget.fontSize != null ? widget.fontSize : 18.0,
            color: Color(0xFF333333)
          ),
          focusNode: model.passwordFocusNode,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.value,
            border: InputBorder.none,
            errorText: false ? '' : null,
            suffixIcon: widget.suffixIcon,
            labelText: widget.label,
          ),
          obscureText: widget.obscureText != null ? widget.obscureText : false,
        ),
      ),
    );
  }
}