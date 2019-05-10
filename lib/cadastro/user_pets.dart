import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPetsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new MyPetsPageState();
  }
}

class MyPetsPageState extends State<MyPetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(child: Text("Teste")),
    );
  }

}
