import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../assets/images.dart';
import './adotar2.dart';
import '../entitys/animal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdotarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AdotarState();
  }
}

class AdotarState extends State<AdotarPage> {
  final index = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        title: new Text("Adotar"),
        backgroundColor: Color(0xFFffd358),
      ),
      body: new StreamBuilder(
          stream: Firestore.instance
              .collection('animals')
              .where('available', isEqualTo: true)
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
                              : 0.0);
                    });
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

  AnimalCard(this.animalname, this.animalimagename, this.genre, this.status,
      this.size, this.location, this.bottomcard);

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
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new Adotar2(
                            this.animalname,
                            this.animalimagename,
                            this.genre,
                            this.size,
                            this.status,
                            this.location),
                      ));
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
