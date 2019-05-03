import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'cadastro_pessoal_elementos.dart';
import '../icons/custom_icons.dart';
import '../common.dart';

class LoginPage extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color(0xff88c9bf),
    ));
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xfffafafa),
      drawer: MyDrawer(name: 'Giordano Monteiro', image: 'assets/cat1.png',),
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ContBar(text: 'Login', scaffoldKey: scaffoldKey,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
          ),
          LoginForm(),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState(){
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          CadPTextField(text: 'Nome de usuário', obscure: false,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          CadPTextField(text: 'Senha', obscure: true),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 26),
          ),
          FlatButton(
              child: CadPButtonCont(text: TextButCad("ENTRAR"),),
              onPressed:() {Navigator.pop(context);},
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 36),
          ),
          FlatButton(
            child: FaceGoogleCont(
              text: TextFaceGoogle("  ENTRAR COM FACEBOOK"),
              color: 0xff194f7c,
              icon: FaceIcon(),
            ),
            onPressed:() {Navigator.pop(context);},
          ),
          FlatButton(
            child: FaceGoogleCont(
                text: TextFaceGoogle("  ENTRAR COM GOOGLE"),
                color: 0xfff15f5c,
                icon: GoogleIcon(),
            ),
            onPressed:() {Navigator.pop(context);},
          ),
        ],
      ),
    );
  }
}

class TextFaceGoogle extends StatelessWidget {
  TextFaceGoogle(this.string);

  final String string;
  @override
  Widget build(BuildContext context) {
    return Text (
      string,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xfff7f7f7),
        fontSize: 12.0,
      ),
    );
  }
}

class FaceGoogleCont extends StatelessWidget {
  FaceGoogleCont({this.text, this.color, this.icon});

  final Widget text, icon;
  final int color;

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
        color: Color(color),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          icon,
          text,
        ],
      ),
    );
  }
}

class FaceIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(CustomIcons.facebook, color: Color(0xfff7f7f7), size: 13,);
  }
}

class GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(CustomIcons.gplus, color: Color(0xfff7f7f7), size: 13,);
  }
}