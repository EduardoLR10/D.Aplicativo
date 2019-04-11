import 'package:flutter/material.dart';


class TestImageWidget extends StatelessWidget {
  final nameofimage;

  TestImageWidget(this.nameofimage);

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: Alignment(0, -0.5),
      child: new Container(
        width: 300,
        height: 300,
        alignment: Alignment.topLeft,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/" + this.nameofimage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}