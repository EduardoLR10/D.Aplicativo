import 'package:flutter/material.dart';
import './assets/images.dart';

class Intro extends StatelessWidget {

  @override
  Widget build(BuildContext context)  {
    return Scaffold( // Widget do MaterialApp
      appBar: MyAppBar(
        title:  Text(
          'Example title',
          style: Theme.of(context) .primaryTextTheme.title,
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget> [
            Divider(),
            Text('Nois geral aqui'),
            Divider(),
            MyButton(),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
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

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{ //Lidando com o AppBar do MaterialApp separadamente
  MyAppBar({this.title});

  final Widget title;

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight); //Possibilita a classe ser tratada como AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading:
      IconButton (
        icon: Icon(Icons.menu),
        tooltip:  'Menu',
        onPressed: null,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Buscar',
          onPressed: null,
        )
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector (
      onTap: () {
        print('Apertou aqui');
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen,
        ),
        child: Center(
          child: Text('Clica'),
        ),
      ),
    );
  }
}