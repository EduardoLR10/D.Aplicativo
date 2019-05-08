import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../assets/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  String nome;
  String dono;
  bool available;
  List<String> interessados = new List<String>();
  Animal.fromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.data.toString());
        nome = snapshot.data['nome'];
        dono = snapshot.data['dono'];
        available = snapshot.data['available'];
        interessados = List.from(snapshot.data['interessados']);
  }
}

Animal getAnimal(DocumentSnapshot snapshot) {//convert
  //Firestore.instance.collection('animals').snapshots((snap) => snap.map((document) => document.data));
    try {
      return Animal.fromSnapshot(snapshot);
    } catch (e) {
      print(e);
      return null;
    }
}
