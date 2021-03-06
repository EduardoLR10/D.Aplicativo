import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import './adotar/adotar.dart';
import './ajudar.dart';

//import './adotar2.dart';
import 'cadastro/login.dart';
import 'cadastro/cad_log.dart';
import 'common.dart';
import 'use_camera.dart';
import 'cadastro/user_pets.dart';
import 'cadastro/users_list.dart';

void main() {
  avaCam();
  runApp(MaterialApp(
    title: 'MEAU',
    routes: {
      'INTRODUCAO': (BuildContext context) => new IntroPage(),
      'ADOTARPAGE1': (BuildContext context) => new AdotarPage(),
      'AJUDAR': (BuildContext context) => new Ajudar(),
      'LOGINPAGE': (BuildContext context) => new LoginPage(),
      'CADLOGPAGE': (BuildContext context) => new CadLogPage(),
      'MYPETSPAGE': (BuildContext context) => new MyPetsPage(),
    },
    home: StartPage(),
  ));
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 1), () {
      SystemChrome.setEnabledSystemUIOverlays([]); //Faz status bar sumir
      Navigator.pushNamed(context, 'INTRODUCAO');
    });
    return new Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'INTRODUCAO');
        },
        child: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/start_meau.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new IntroState();
  }
}

class IntroState extends State<IntroPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _messaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _messaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print("onMessage: $message");
        onSelectNotification(message["notification"]["title"],
            message["notification"]["body"], message["data"]["screen"]);
      },
      onResume: (Map<String, dynamic> message) {
        print("onResume: $message");
        pushPageNot(message["data"]["screen"]);
      },
      onLaunch: (Map<String, dynamic> message) {
        print("onLaunch: $message");
        pushPageNot(message["data"]["screen"]);
      },
    );
  }

  Future onSelectNotification(String title, String body, String screen) async {
    showDialog(
        context: context,
        builder: (_) {
          return new AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'VERIFICAR',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff757575),
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(screen);
                },
              ),
              FlatButton(
                child: Text(
                  'Cancelar',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff757575),
                    fontSize: 14.0,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future pushPageNot(String name) async {
    Navigator.of(context).pushNamed(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Widget do MaterialApp
      //appBar: IntroAppBar(),
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      drawer: MyDrawer(),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, position) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  width: 360,
                  height: 48,
                  child: IconButton(
                    icon: IconIntro(),
                    tooltip: 'Menu',
                    onPressed: () async {
                      scaffoldKey.currentState.openDrawer();
                    },
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
                    )),
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
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                ),
                Column(children: <Widget>[
                  FlatButton(
                    child: IntroButton(
                      name: TextButIntro('ADOTAR'),
                    ),
                    onPressed: () {
                      SystemChrome.setEnabledSystemUIOverlays(
                          SystemUiOverlay.values); //Faz status bar voltar
                      Navigator.pushNamed(context, 'ADOTARPAGE1')
                          .then((context) {
                        SystemChrome.setEnabledSystemUIOverlays([]);
                      }); //Faz status bar desaparecer
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  FlatButton(
                    child: IntroButton(
                      name: TextButIntro('AJUDAR'),
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
                      name: TextButIntro('CADASTRAR ANIMAL'),
                    ),
                    onPressed: () {
                      SystemChrome.setEnabledSystemUIOverlays(
                          SystemUiOverlay.values);
                      Navigator.pushNamed(context, 'CADLOGPAGE')
                          .then((context) {
                        SystemChrome.setEnabledSystemUIOverlays([]);
                      }); //Faz status bar voltar
                    },
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 22.0),
                ),
                GestureDetector(
                    onTap: () {
                      SystemChrome.setEnabledSystemUIOverlays(
                          SystemUiOverlay.values); //Faz status bar voltar
                      Navigator.pushNamed(context, 'LOGINPAGE').then((context) {
                        SystemChrome.setEnabledSystemUIOverlays([]);
                      }); //Faz status bar desaparecer
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
                    )),
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
            );
          }),
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
