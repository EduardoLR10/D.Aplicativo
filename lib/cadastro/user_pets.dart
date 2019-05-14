import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cadastro_pessoal_elementos.dart';
import '../adotar/adotar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../common.dart' as userthings;
import 'package:firebase_database/firebase_database.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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
      //backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        title: new Text("Meus Pets"),
        iconTheme: new IconThemeData(color: Color(0xffcfe9e5)),
        backgroundColor: Color(0xff88c9bf),
      ),
      body: new StreamBuilder(
          stream: FirebaseDatabase.instance
          .reference()
          .child("animals")
          .orderByChild("dono")
          .equalTo(userthings.user.uid).onValue,
          builder: (context, snap) {
            switch (snap.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              default:
                DataSnapshot snapshot = snap.data.snapshot;
                List item = [];
                List _list = [];
                _list = snapshot.value;
                _list.forEach((f) {
                  if (f != null) {
                    item.add(f);
                  }
                });
                return ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, position) {
                      return AnimalCard(
                          item[position]['nome'],
                          item[position]['url'],
                          item[position]['genero'].toString().toUpperCase(),
                          item[position]['idade'].toString().toUpperCase(),
                          item[position]['porte'].toString().toUpperCase(),
                          item[position]['endereco'].toString().toUpperCase(),
                          (item[position] == item.last) ? 8.0 : 0.0,
                          0);
                    });
            }
          }),
    );
  }
}

class PetBar extends StatelessWidget {
  PetBar({this.text, this.scaffoldKey});

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
                tooltip: 'Menu',
                onPressed: () {
                  scaffoldKey.currentState.openDrawer();
                },
              ),
            ),
            TextAppBarCad(text),
          ],
        ),
      ),
    );
  }
}
