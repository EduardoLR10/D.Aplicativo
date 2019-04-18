import 'package:flutter/material.dart';


class CustomImageWidget extends StatelessWidget {
  final nameofimage;
  final widthimage;
  final heightimage;

  CustomImageWidget(this.nameofimage, this.widthimage, this.heightimage);

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: Alignment(0, -0.5),
      child: new Container(
        width: this.widthimage,
        height: this.heightimage,
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