import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CadPButtonCont extends StatelessWidget {
  CadPButtonCont({this.text});

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 232.0,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 1.0,
            spreadRadius: 1.0,
            offset: Offset(
              0.0,
              1.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(2.0),
        color: Color(0xff88c9bf),
      ),
      child: Center(
        child: text,
      ),
    );
  }
}

class TextButCad extends StatelessWidget {
  TextButCad(this.string);

  final String string;

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xff434343),
        fontSize: 12.0,
      ),
    );
  }
}

class TextAppBarCad extends StatelessWidget {
  TextAppBarCad(this.string);

  final String string;

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Robotto',
        fontWeight: FontWeight.w500,
        color: Color(0xff434343),
        fontSize: 20.0,
      ),
    );
  }
}

class IconMenuCadP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: new IconThemeData(
        color: Color(0xff434343),
        size: 24.0,
      ),
      child: new Icon(Icons.menu),
    );
  }
}

class ContBar extends StatelessWidget {
  ContBar({this.text, @required this.scaffoldKey});

  final String text;
  var scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(0),
        alignment: Alignment.centerLeft,
        constraints: BoxConstraints(),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: Color(0xffcfe9e5),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(
                0.0,
                1.0,
              ),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: IconButton(
                icon: IconMenuCadP(),
                tooltip:  'Menu',
                onPressed: (){scaffoldKey.currentState.openDrawer();},
              ),
            ),
            TextAppBarCad(text),
          ],
        ),
      ),
    );
  }
}

class CadPTextField extends StatefulWidget {
  CadPTextField({this.text: 'ENTER', this.obscure: false, this.strings, this.callback});
  final String text;
  final bool obscure;

  final String strings;
  final Function(String) callback;

  @override
  CadPTextFieldState createState(){
    return new CadPTextFieldState(obscure: obscure, text: text);
  }
}

class CadPTextFieldState extends State<CadPTextField> {
  CadPTextFieldState(this.obscure, {this.text: 'ENTER'});
  final TextEditingController _fieldcontroller = TextEditingController();
  final String text;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 312, maxHeight: 30),
      child: TextFormField(
        controller: _fieldcontroller,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
        onEditingComplete: widget.callback(_fieldcontroller.text),
        obscureText: password,
        style: TextStyle(
            fontFamily: 'Robotto', color: Color(0xff575756), fontSize: 14.0),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            fontFamily: 'Robotto',
            color: Color(0xffbdbdbd),
            fontSize: 14.0,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0.8, color: Color(0xffe6e7e8))),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xff88c9bf)),
          ),
          hasFloatingPlaceholder: false,
          contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 8),
          suffix: CheckField(),
        ),
      ),
    );
  }
}

class CheckField extends StatefulWidget {
  @override
  CheckFieldState createState() {
    return new CheckFieldState();
  }
}

class CheckFieldState extends State<CheckField> {
  @override
  Widget build(BuildContext context) {
    if (usernameFormat())
      return Icon(Icons.check, color: Color(0xff589b9b));
    else
      return Padding(
        padding: EdgeInsets.all(0),
      );
  }
}

bool usernameFormat() {
  if (false)
    return false;
  else
    return true;
}
