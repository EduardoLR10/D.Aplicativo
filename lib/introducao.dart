import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
          Container(child:
            Text(
              'Nois geral aqui',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontStyle: FontStyle.),
            )
          ),
          Text('Textão'),
          Column(
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
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
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
        size: 24.0,
      ),
      child: new Icon(Icons.menu),
    );
  }
}
