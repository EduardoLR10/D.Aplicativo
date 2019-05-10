import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cadastro_pessoal_elementos.dart';
import '../adotar/adotar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../common.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyPetsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyPetsPageState();
  }
}

class MyPetsPageState extends State<MyPetsPage> {

  String user;
  DocumentReference reference;

  @override
  initState() {
    super.initState();
    doAsyncStuff();
    user = '';
  }

  doAsyncStuff() async {
    FirebaseUser currentUser = await _auth.currentUser();
    this.user = currentUser.uid;
    this.reference = Firestore.instance.collection('users').document(user);
    print(this.user);
  }

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
          stream: Firestore.instance
              .collection('animals')
              .where('dono', isEqualTo: (this.reference))
              .snapshots()
              .map((snap) => snap.documents.map((document) {
                    var ref = document.data['interessados']
                        .map((interessado) => interessado.path);
                    document.data['interessados'] = ref;
                    return document.data;
                  })),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                //print("carregando");
                return Center(child: CircularProgressIndicator());
                break;
              default:
                //print(snapshot.data.toString());
                //return new Text("teste");
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, position) {
                      return AnimalCard(
                          snapshot.data.elementAt(position)['nome'],
                          snapshot.data.elementAt(position)['url'],
                          snapshot.data
                              .elementAt(position)['genero']
                              .toString()
                              .toUpperCase(),
                          snapshot.data
                              .elementAt(position)['idade']
                              .toString()
                              .toUpperCase(),
                          snapshot.data
                              .elementAt(position)['porte']
                              .toString()
                              .toUpperCase(),
                          snapshot.data
                              .elementAt(position)['endereco']
                              .toString()
                              .toUpperCase(),
                          (snapshot.data.elementAt(position) ==
                                  snapshot.data.last)
                              ? 8.0
                              : 0.0, 1);
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
