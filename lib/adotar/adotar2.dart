import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../assets/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../entitys/animal.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Adotar2 extends StatefulWidget {
  final id;
  final name;
  final imagename;
  final genre;
  final status;
  final size;
  final location;

  Adotar2(this.name, this.id, this.imagename, this.genre, this.size, this.status,
      this.location);
  @override
  State<StatefulWidget> createState() {
    return new AdotarState2(name, id, imagename, genre, size, status, location);
  }
}

class AdotarState2 extends State<Adotar2> {
  var id;
  var name;
  var imagename;
  var genre;
  var status;
  var size;
  var location;

  var existence = false;

  AdotarState2(this.name, this.id, this.imagename, this.genre, this.size, this.status,
      this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          this.name,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Color(0xff434343),
            fontSize: 26.667,
          ),
        ),
        backgroundColor: Color(0xFFffd358),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Color(0xfffafafa),
        foregroundColor: Color(0xff434343),
        //shape: new CircleBorder(Border),
        child: new Icon(Icons.favorite_border),
        onPressed: null,
      ),
      body: new ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: 360,
                height: 184,
                padding: new EdgeInsets.all(0.0),
                child: new CustomImageWidget(this.imagename, 360.0, 184.0),
              ),
              new Padding(
                padding: EdgeInsets.only(
                  top: 21.33,
                  bottom: 21.33,
                  left: 10.667,
                ),
                child: new Text(
                  this.name,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff434343),
                    fontSize: 21.33,
                  ),
                ),
              ),
              new Row(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(
                      left: 10.667,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "SEXO",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xfff7a800),
                            fontSize: 16,
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(
                            top: 10.667,
                          ),
                          child: new Text(
                            this.genre,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff757575),
                              fontSize: 18.667,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "PORTE",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xfff7a800),
                            fontSize: 16,
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(
                            top: 10.667,
                          ),
                          child: new Text(
                            this.size,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff757575),
                              fontSize: 18.667,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "IDADE",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xfff7a800),
                          fontSize: 16,
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(
                          top: 10.667,
                        ),
                        child: new Text(
                          this.status,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xff757575),
                            fontSize: 18.667,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              new Padding(
                padding: new EdgeInsets.only(
                  top: 21.33,
                  left: 10.667,
                ),
                child: new Text(
                  "LOCALIZAÇÃO",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xfff7a800),
                    fontSize: 16,
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(
                  top: 10.667,
                  left: 10.667,
                ),
                child: new Text(
                  this.location,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff757575),
                    fontSize: 18.667,
                  ),
                ),
              ),
              new Row(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(
                      left: 10.667,
                      top: 42.667,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "CADASTRADO",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xfff7a800),
                            fontSize: 16,
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(
                            top: 10.667,
                          ),
                          child: new Text(
                            "Não",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff757575),
                              fontSize: 18.667,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                      left: 70,
                      top: 42.667,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "VERMIFUGADO",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xfff7a800),
                            fontSize: 16,
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(
                            top: 10.667,
                          ),
                          child: new Text(
                            "Não",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff757575),
                              fontSize: 18.667,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(
                      left: 10.667,
                      top: 21.33,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "VACINADO",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xfff7a800),
                            fontSize: 16,
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(
                            top: 10.667,
                          ),
                          child: new Text(
                            "Não",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff757575),
                              fontSize: 18.667,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(
                      left: 95,
                      top: 21.33,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "DOENÇAS",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xfff7a800),
                            fontSize: 16,
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(
                            top: 10.667,
                          ),
                          child: new Text(
                            "Nenhuma",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff757575),
                              fontSize: 18.667,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              new Padding(
                padding: new EdgeInsets.only(
                  left: 10.667,
                  top: 42.667,
                ),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "TEMPERAMENTO",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xfff7a800),
                        fontSize: 16,
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(
                        top: 10.667,
                      ),
                      child: new Text(
                        "Puto",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff757575),
                          fontSize: 18.667,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(
                  left: 10.667,
                  top: 42.667,
                ),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "EXIGÊNCIAS DO DOADOR",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xfff7a800),
                        fontSize: 16,
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(
                        top: 10.667,
                      ),
                      child: new Text(
                        "Eu, como doador, espero que meu animal seja cuidado com carinho e que toda sua raiva seja respeitada em prol da zueira.",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff757575),
                          fontSize: 18.667,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(
                  left: 10.667,
                  top: 42.667,
                ),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "MAIS SOBRE " + this.name.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xfff7a800),
                        fontSize: 16,
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(
                        top: 10.667,
                      ),
                      child: new Text(
                        "Esse animal é um pet bastante incomodado com a vida e sempre, apesar de parecer dócil as vezes, está puto com a vida e com o dono.",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff757575),
                          fontSize: 18.667,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                child: new FlatButton(
                  onPressed: () async {
                    final FirebaseUser user = await _auth.currentUser();
                    setState(() {
                      if(user == null)
                      {
                        Navigator.pushNamed(context, 'LOGINPAGE');
                      }
                      else {
                        checkanimals();
                      }
                    });
                  },
                  child: new Container(
                    height: 40.0,
                    width: 232.0,
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                            0.0,
                            1.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(2.0),
                      color: Color(0xfffdcf58),
                    ),
                    child: Center(
                      child: new Text(
                        "PRETENDO ADOTAR",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff434343),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void checkanimals() async {
    final FirebaseUser user = await _auth.currentUser();
    var new_id = 0;
    int counter = 0;
    //print(this.id.toString());
    FirebaseDatabase.instance
    .reference()
    .child("animals")
    .child(this.id.toString())
    .child("interessados")
    .once()
    .then((onValue){
      List data = onValue.value;
      checkExistence();
      if(this.existence == false){
        if(data == null){
          new_id = 0;
        }else{
          while(counter < data.length)
          {
            if(data[counter] == null)
              break;
            counter ++;
          }
          new_id = counter;
        }
        FirebaseDatabase.instance
        .reference()
        .child("animals")
        .child(this.id.toString())
        .child("interessados/" + new_id.toString())
        .set({
          "id": new_id,
          "user_uid": user.uid
        }).whenComplete((){
          print('passei por aqui');
        });
      }
    });
  }
  void checkExistence() async {
    final FirebaseUser user = await _auth.currentUser();
    FirebaseDatabase.instance
    .reference()
    .child("animals")
    .child(this.id.toString())
    .child("interessados")
    .orderByChild("user_uid")
    .equalTo(user.uid)
    .once()
    .then((onValue){
      List data = onValue.value;
      if(data == null){
        setState(() {
          this.existence = false;
        });
      }else{
        setState(() {
          this.existence = true;
        });
      }
    });
  }
}
