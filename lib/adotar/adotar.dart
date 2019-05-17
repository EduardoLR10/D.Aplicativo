import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../assets/images.dart';
import './adotar2.dart';
import '../cadastro/users_list.dart';
import '../entitys/animal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'dart:async';

class AdotarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AdotarState();
  }
}

class AdotarState extends State<AdotarPage> {
  //StreamSubscription<Event> ref2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        title: new Text("Adotar"),
        backgroundColor: Color(0xFFffd358),
      ),
      body: new StreamBuilder(
          stream: FirebaseDatabase.instance
              .reference()
              .child("animals")
              .orderByChild("available")
              .equalTo(true)
              .onValue,
          builder: (context, snap) {
            switch (snap.connectionState) {
              case ConnectionState.waiting:
                //print("carregando");
                return Center(child: CircularProgressIndicator());
                break;
              default:
                //print(snapshot.data.toString());
                //return new Text("teste");
                DataSnapshot snapshot = snap.data.snapshot;
                List item = [];
                List _list = [];
//it gives all the documents in this list.
                _list = snapshot.value;
                if(_list == null){
                  return new Padding(padding: EdgeInsets.all(0.0));
                }else{
                  _list.forEach((f) {
                    if (f != null) {
                      item.add(f);
                    }
                  });
                  //print(item.length);
                  return ListView.builder(
                      itemCount: item.length,
                      itemBuilder: (context, position) {
                        return AnimalCard(
                            item[position]['nome'],
                            item[position]['url'],
                            item[position]['id'],
                            item[position]['genero'].toString().toUpperCase(),
                            item[position]['idade'].toString().toUpperCase(),
                            item[position]['porte'].toString().toUpperCase(),
                            item[position]['endereco'].toString().toUpperCase(),
                            (item[position] == item.last) ? 8.0 : 0.0,
                            0);
                      });
                }
            }
          }),
    );
  }
}

class AnimalCard extends StatelessWidget {
  final animalname;
  final animalimagename;
  final genre;
  final status;
  final size;
  final location;
  final bottomcard;
  final whichpage;
  final id;

  AnimalCard(this.animalname, this.animalimagename, this.id, this.genre, this.status,
      this.size, this.location, this.bottomcard, this.whichpage);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Card(
          margin: new EdgeInsets.only(
              top: 8.0, left: 8.0, right: 8.0, bottom: bottomcard),
          child: new Container(
            width: 344,
            height: 264,
            child: new Column(children: <Widget>[
              new Container(
                width: 344,
                height: 32,
                padding: new EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0)),
                  color: Color(0xfffee29b),
                ),
                child: new Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    new Align(
                      alignment: Alignment(-0.91, 0.0),
                      child: new Text(
                        this.animalname,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff434343),
                          fontSize: 21.3,
                        ),
                      ),
                    ),
                    new IconButton(
                      alignment: Alignment(37.0, 1.0),
                      icon: new Icon(Icons.favorite),
                      onPressed: null,
                    ),
                  ],
                ),
              ),
              new FlatButton(
                padding: new EdgeInsets.all(0.0),
                onPressed: () {
                  //print(this.id);
                  if (this.whichpage == 0) {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new Adotar2(
                              this.animalname,
                              this.id,
                              this.animalimagename,
                              this.genre,
                              this.size,
                              this.status,
                              this.location),
                        ));
                  } else {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new WantToAdoptListPage(
                                this.id,
                              ),
                        ));
                  }
                },
                child: new Column(
                  children: <Widget>[
                    new CustomImageWidget(this.animalimagename, 344.0, 183.0),
                    new Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(this.genre,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xff434343),
                                fontSize: 16.0,
                              )),
                          new Text(this.status,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xff434343),
                                fontSize: 16.0,
                              )),
                          new Text(this.size,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xff434343),
                                fontSize: 16.0,
                              )),
                        ],
                      ),
                    ),
                    new Container(
                      //padding: new EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: new Text(
                        this.location,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff434343),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
