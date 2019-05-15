import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cadastro_pessoal_elementos.dart';
import '../adotar/adotar.dart';
import '../common.dart' as userthings;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class WantToAdoptListPage extends StatefulWidget {
  final id;

  WantToAdoptListPage(this.id);
  @override
  State<StatefulWidget> createState() {
    return new WantToAdoptListState(id);
  }
}

class WantToAdoptListState extends State<WantToAdoptListPage> {
  final id;
  WantToAdoptListState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xfffafafa),
        appBar: AppBar(
          title: new Text("Candidatos"),
          iconTheme: new IconThemeData(color: Color(0xffcfe9e5)),
          backgroundColor: Color(0xff88c9bf),
        ),
        body: new StreamBuilder(
            stream: FirebaseDatabase.instance
                .reference()
                .child("animals/" + this.id.toString() + "/interessados")
                .onValue,
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
                  if(_list == null){
                    return Padding(padding: EdgeInsets.all(0),);
                  }else{
                    _list.forEach((f) {
                      if (f != null) {
                        item.add(f);
                      }
                    });
                    return ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, position) {
                          return GetUserData(item[position], this.id);
                        });
                  }
                  break;
              }
            })

        //new ListView.builder(
        //itemCount: 1,
        //itemBuilder: (context, position) {
        //return Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
        //  mainAxisAlignment: MainAxisAlignment.start,
        //  children: <Widget>[
        //    AnimalCandidate("VJ7pvBFTB8RExMRdwFkZI2u8cW12", "Eduardo Lemos", name.toString().toLowerCase()),
        //    AnimalCandidate("I3mIhMgW0la0sEtQe80BaxKzANE3", "Giordano Monteiro", name.toString().toLowerCase()),
        //  ],
        );
  }
}

class GetUserData extends StatefulWidget {
  final animalid;
  final hashkey;
  GetUserData(this.hashkey, this.animalid);

  @override
  State<StatefulWidget> createState() {
    return new GetUserDataState(hashkey, animalid);
  }
}

class GetUserDataState extends State<GetUserData> {
  var _user = '';
  var name = '';
  var hashkey;
  var animalid;
  GetUserDataState(this.hashkey, this.animalid);
  @override
  Widget build(BuildContext context) {
    getName();
    return  AnimalCandidate(this.name, this.animalid, this.hashkey);
  }

  void getName() {
    var user_data = FirebaseDatabase.instance
        .reference()
        .child("users")
        .orderByChild("user_uid")
        .equalTo(this.hashkey)
        .onChildAdded
        .listen((Event event) {
          setState(() {
            this.name = '${event.snapshot.value['nome_user']}';
          });
      });
    }
}

class AnimalCandidate extends StatelessWidget {
  String _user;
  String name;
  var nome_user;
  var animalid;
  String hashkey;
  AnimalCandidate(this.nome_user, this.animalid, this.hashkey);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(this.nome_user),
            IconButton(
                icon: Icon(Icons.check_circle),
                onPressed: () {
                  checkAdot();
                  Navigator.of(context).pop();
                }),
            Divider(),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  notAdot();
                  Navigator.of(context).pop();
                }),
          ],
        )
      ],
    );
  }

  void checkAdot() async {
    FirebaseDatabase.instance
    .reference()
    .child("animals")
    .child(this.animalid.toString())
    .update({
      //"id": 1,
      //"porte": "Grande",
      //"idade": "Adulto",
      //"genero": "Macho",
      //"endereco": "Guará Norte - Distrito Federel",
      //"nome": "Bob",
      "url": "https://firebasestorage.googleapis.com/v0/b/meau-f8464.appspot.com/o/dog1.png?alt=media&token=48ad5f98-1f41-4514-a890-fe5e7579b3f9",
      "dono": this.hashkey,
      "available": false,
      "interessados": []
    });
  }

  void notAdot() async {
    FirebaseDatabase.instance
    .reference()
    .child("animals/" + this.animalid.toString())
    .update({
      "interessados": []
    });
  }
}
