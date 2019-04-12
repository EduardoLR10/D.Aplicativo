import 'package:flutter/material.dart';
import './assets/images.dart';

class Intro extends StatelessWidget {

  @override
  Widget build(BuildContext context)  {
    return Scaffold( // Widget do MaterialApp
      //appBar: IntroAppBar(),
      body: Column(
        children: <Widget> [
          Row(
            children: <Widget> [
              IconButton (
                icon: IconIntro(),
                tooltip:  'Menu',
                onPressed: null,
              ),
            ]
          ),
          Text('Nois geral aqui'),
          Text('Textão'),
          Column(
            mainAxisAlignment:,
            children: <Widget> [
              IntroButton(
                name: Text ('ADOTAR'),
              ),
              IntroButton(
                name: Text ('AJUDAR'),
              ),
              IntroButton(
                name: Text ('CADASTRAR ANIMAL'),
              ),
            ]
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: 'btn3',
        child: Text('Back'),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class IntroButton extends StatelessWidget {
  IntroButton({this.name});

  final Widget name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
      onTap: () {
        print('Apertou aqui');
      },
      child: Container(
        height: 40.0,
        width: 232.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: Color(0xffffd358),
        ),
        child: Center(
          child: name,
        ),
      ),
    );
  }
}

class IconIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: new IconThemeData(
        color: Color(0xff88c9bf),
      ),
      child: new Icon(Icons.menu),
    );
  }
}