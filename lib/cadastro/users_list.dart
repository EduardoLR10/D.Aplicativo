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
                .child("animals")
                .child(this.id.toString())
                .child("interessados")
                .orderByChild("user_uid")
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
                  if (_list == null) {
                    return new Center(
                        child: new FlatButton(
                      onPressed: () async {
                        FirebaseDatabase.instance
                            .reference()
                            .child("animals")
                            .child(this.id.toString())
                            .update({"available": true});
                        Navigator.of(context).pop();
                      },
                      child: new Text("HABILITAR ADOÇÃO"),
                    ));
                  } else {
                    _list.forEach((f) {
                      if (f != null) {
                        item.add(f['user_uid']);
                      }
                    });
                    return ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, position) {
                          return GetUserData(item[position], this.id, position);
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
  final interestedid;
  GetUserData(this.hashkey, this.animalid, this.interestedid);

  @override
  State<StatefulWidget> createState() {
    return new GetUserDataState(hashkey, animalid, interestedid);
  }
}

class GetUserDataState extends State<GetUserData> {
  var name = '';
  var hashkey;
  var animalid;
  var interestedid;
  GetUserDataState(this.hashkey, this.animalid, this.interestedid);
  @override
  Widget build(BuildContext context) {
    getName();
    return AnimalCandidate(
        this.name, this.animalid, this.interestedid, this.hashkey);
  }

  void getName() {
    FirebaseDatabase.instance
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
  String name;
  var nome_user;
  var animalid;
  var interestedid;
  String hashkey;
  AnimalCandidate(
      this.nome_user, this.animalid, this.interestedid, this.hashkey);
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
        .update({"dono": this.hashkey, "available": false, "interessados": []});
  }

  void notAdot() async {
    FirebaseDatabase.instance
        .reference()
        .child("animals")
        .child(this.animalid.toString())
        .child("interessados")
        .child(this.interestedid.toString())
        .remove();
  }
}
