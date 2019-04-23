import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

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

class ScaffoldCadP extends StatefulWidget{
  ScaffoldCadP({this.body});

  final Widget body;

  @override
  State<StatefulWidget> createState() {
    return new ScaffoldCadPState(body: body);
  }
}

class ScaffoldCadPState extends State<ScaffoldCadP>{
  ScaffoldCadPState({this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Color(0xfffafafa),
      body: body,
    );
  }
}