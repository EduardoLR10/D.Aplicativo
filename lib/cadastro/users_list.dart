import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cadastro_pessoal_elementos.dart';
import '../adotar/adotar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class WantToAdoptListPage extends StatefulWidget {
  final name;

  WantToAdoptListPage(this.name);
  @override
  State<StatefulWidget> createState() {
    return new WantToAdoptListState(name);
  }
}

class WantToAdoptListState extends State<WantToAdoptListPage> {
  final name;

  WantToAdoptListState(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xfffafafa),
        appBar: AppBar(
          title: new Text("Candidatos"),
          iconTheme: new IconThemeData(color: Color(0xffcfe9e5)),
          backgroundColor: Color(0xff88c9bf),
        ),
        body: new ListView.builder(
        itemCount: 1,
        itemBuilder: (context, position) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AnimalCandidate("VJ7pvBFTB8RExMRdwFkZI2u8cW12", "Eduardo Lemos", name.toString().toLowerCase()),
            AnimalCandidate("I3mIhMgW0la0sEtQe80BaxKzANE3", "Giordano Monteiro", name.toString().toLowerCase()),
          ],
        );
    })
    );
  }
}

class AnimalCandidate extends StatelessWidget {
  String _user;
  String user_name;
  String name;
  AnimalCandidate(this._user, this.user_name ,this.name);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(this.user_name),
            IconButton(icon: Icon(Icons.check_circle), onPressed: (){checkAdot();
            Navigator.of(context).pop();}),
            Divider(),
            IconButton(icon: Icon(Icons.close), onPressed: (){notAdot();
            Navigator.of(context).pop();}),
          ],
        )
      ],
    );
  }
  void checkAdot() async {
    final FirebaseUser user = await _auth.currentUser();
    DocumentReference ref = Firestore.instance.collection('users').document(_user);
    Firestore.instance
        .collection('animals')
        .document(name)
        .updateData({'dono': ref, 'available': false,
      'interessados' : []},);
  }
  void notAdot() async {
    final FirebaseUser user = await _auth.currentUser();
    Firestore.instance
        .collection('animals')
        .document(name)
        .setData({'interessados' : []},
        merge: true);
  }

}
