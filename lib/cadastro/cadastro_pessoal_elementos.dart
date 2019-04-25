import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CadPButtonCont extends StatelessWidget {
  CadPButtonCont({this.text});

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Container (
      height: 40.0,
      width: 232.0,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
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
    return Text (
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
    return Text (
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
  ContBar({this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(0),
        alignment: Alignment.centerLeft,
        constraints: BoxConstraints(),
        height: 56,
        decoration:
        BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: Color(0xffcfe9e5),
          boxShadow: [BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(
              0.0,
              1.0,
            ),
          )],
        ),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Padding (
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: IconButton (
                icon: IconMenuCadP(),
                tooltip:  'Menu',
                onPressed: null,
              ),
            ),
            TextAppBarCad(text),
          ],
        ),
      ),
    );
  }
}