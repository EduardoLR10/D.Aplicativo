import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import './adotar.dart';
import './ajudar.dart';
//import './adotar2.dart';
import 'cadastro/login.dart';
import 'cadastro/cad_log.dart';

void main() {
  runApp(MaterialApp(
    title: 'MEAU',
    routes: {
      'INTRODUCAO' : (BuildContext context) => new MainPage(),
      'ADOTARPAGE1': (BuildContext context) => new AdotarPage(),
<<<<<<< HEAD
      'AJUDAR': (BuildContext context) => new Ajudar(),
=======
      'LOGINPAGE' : (BuildContext context) => new LoginPage(),
      'CADLOGPAGE' : (BuildContext context) => new CadLogPage(),
>>>>>>> f8d9f02f850935485f5f5538948574b6490dd3a6
    },
    home: StartPage(),
  ));
}

class StartPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    new Future.delayed(const Duration(seconds: 1), () {
      SystemChrome.setEnabledSystemUIOverlays([]); //Faz status bar sumir
      Navigator.pushNamed(context, 'INTRODUCAO');
    });
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/start_meau.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainState();
  }
}

class MainState extends State<MainPage> {
  @override
  Widget build (BuildContext context) {
    return Intro();
  }
}

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {

    return Scaffold( // Widget do MaterialApp
      //appBar: IntroAppBar(),
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Container(
            alignment: Alignment.centerLeft,
            width: 360,
            height: 48,
            child:
              IconButton (
                icon: IconIntro(),
                tooltip:  'Menu',
                onPressed: null,
              ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
          ),
          Container(
            alignment: Alignment.center,
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 26.0),
          ),
          Container(
            alignment: Alignment.center,
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
          ),
          Column(
            children: <Widget> [
              FlatButton(
                child: IntroButton(
                name: TextButIntro ('ADOTAR'),
                ),
                onPressed: () {
                  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values); //Faz status bar voltar
                  Navigator.pushNamed(context, 'ADOTARPAGE1').then((context){SystemChrome.setEnabledSystemUIOverlays([]);}); //Faz status bar desaparecer
                }, 
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
              ),
              FlatButton(
                child: IntroButton(
                name: TextButIntro ('AJUDAR'),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'AJUDAR');
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
              ),
              FlatButton(
                child: IntroButton(
                name: TextButIntro ('CADASTRAR ANIMAL'),
                ),
                onPressed: () {
                  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                  Navigator.pushNamed(context, 'CADLOGPAGE').then((context){SystemChrome.setEnabledSystemUIOverlays([]);});//Faz status bar voltar
                },
              ),
            ]
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 22.0),
          ),
          GestureDetector(
            onTap: () {
              SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values); //Faz status bar voltar
              Navigator.pushNamed(context, 'LOGINPAGE').then((context){SystemChrome.setEnabledSystemUIOverlays([]);}); //Faz status bar desaparecer
            },
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
          ),
          Container(
            width: 122,
            height: 44,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/Meau_marca_2.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}

class IntroButton extends StatelessWidget {
  IntroButton({this.name});

  final Widget name;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          color: Color(0xffffd358),
        ),
        child: Center(
          child: name,
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