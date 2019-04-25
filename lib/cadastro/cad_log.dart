import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'cadastro_pessoal_elementos.dart';
import 'login.dart';

class CadLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xff589b9b),
    ));
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xfffafafa),
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CadLogBar(text: 'Cadastro'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 26.0),
          ),
          Text('Ops!',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Courgette',
              color: Color(0xff88c9bf),
              fontSize: 53.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 26.0),
          ),
          Text('Você não pode realizar essa ação sem\npossuir um cadastro.',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xff757575),
              fontSize: 14.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          FlatButton(
            child: CadPButtonCont(text: TextButCad("FAZER CADASTRO")),
            onPressed:() {Navigator.pop(context);},
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 22.0),
          ),
          Text('Já possui cadastro?',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xff757575),
              fontSize: 14.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          FlatButton(
            child: CadPButtonCont(text: TextButCad("FAZER LOGIN")),
            onPressed:() {Navigator.pushNamed(context, 'LOGINPAGE');},
          ),
        ],
      ),
    );
  }
}

class CadLogBar extends StatelessWidget {
  CadLogBar({this.text});

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
          color: Color(0xff88c9bf),
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
                icon: IconArrowCadLog(),
                tooltip:  'Voltar',
                onPressed: () {Navigator.pop(context);},
              ),
            ),
            TextAppBarCad(text),
          ],
        ),
      ),
    );
  }
}

class IconArrowCadLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: new IconThemeData(
        color: Color(0xff434343),
        size: 24.0,
      ),
      child: new Icon(Icons.arrow_back),
    );
  }
}