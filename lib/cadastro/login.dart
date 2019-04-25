import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'cadastro_pessoal_elementos.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color(0xff88c9bf),
    ));
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ContBar(text: 'Login'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
          ),
        ],
      ),
    );
  }
}