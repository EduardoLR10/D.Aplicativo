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
        body: new StreamBuilder(
            stream: Firestore.instance
                .collection('animals')
                .document(name.toString().toLowerCase())
                .snapshots()
                .map((snap) => snap.data['interessados']
                    .map((interessado) => interessado.path)),
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
                        return AnimalCandidate(snapshot.data.element(position), name.toString().toLowerCase());
                      });
              }
            }));
  }
}

class AnimalCandidate extends StatelessWidget {
  String user;
  String name;
  AnimalCandidate(this.user, this.name);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(this.user),
            IconButton(icon: Icon(Icons.check_circle), onPressed: (){checkAdot();}),
            IconButton(icon: Icon(Icons.close), onPressed: (){notAdot();}),
          ],
        )
      ],
    );
  }
  void checkAdot() async {
    final FirebaseUser user = await _auth.currentUser();
    Firestore.instance
        .collection('animals')
        .document(name)
        .setData({'dono': ('users/' + user.uid), 'available': false,
      'interessados' : []},
        merge: true);
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
