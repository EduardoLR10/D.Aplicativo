import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class Intro extends StatelessWidget {

  @override
  Widget build(BuildContext context)  {
    return Scaffold( // Widget do MaterialApp
      //appBar: IntroAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Container(
            width: 360,
            height: 48,
            alignment: Alignment.topLeft,
            child:
              IconButton (
                icon: IconIntro(),
                tooltip:  'Menu',
                onPressed: null,
              ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Olá!',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Courgette',
                color: Color(0xffffd358),
                fontSize: 72.0,
              ),
            )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(48, 44, 48, 42),
            child: Text(
              'Bem vindo ao Meau!\nAqui você pode adotar, doar e ajudar\n'
                  'cães e gatos com facilidade.\nQual o seu interesse?',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xff757575),
                fontSize: 16.0,
              ),
            )
          ),
          Column(
            children: <Widget> [
              IntroButton(
                name: TextButIntro ('ADOTAR'),
              ),
              IntroButton(
                name: TextButIntro ('AJUDAR'),
              ),
              IntroButton(
                name: TextButIntro ('CADASTRAR ANIMAL'),
              ),
            ]
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 38),
            child: Text(
              'login',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xff88c9bf),
                fontSize: 16.0,
              ),
            )
          ),
          Container(
            width: 122,
            height: 44,
            //margin: EdgeInsets.fromLTRB(0, 30, 0, 32),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/Meau_marca_2.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: 'btn3',
        child: Text('Back'),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class IntroButton extends StatelessWidget {
  IntroButton({this.name});

  final Widget name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
      child: Container(
        height: 40.0,
        width: 232.0,
        margin: const EdgeInsets.symmetric(vertical: 6.0),
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
          color: Color(0xffffd358),
        ),
        child: Center(
          child: name,
        ),
      ),
    );
  }
}

class IconIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: new IconThemeData(
        color: Color(0xff88c9bf),
        size: 24.0,
      ),
      child: new Icon(Icons.menu),
    );
  }
}

class TextButIntro extends StatelessWidget {
  TextButIntro(this.string);

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