import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  final urlofimage;
  final widthimage;
  final heightimage;

  CustomImageWidget(this.urlofimage, this.widthimage, this.heightimage);

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: Alignment(0, -0.5),
      child: new Container(
        width: this.widthimage,
        height: this.heightimage,
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          image: new DecorationImage(
              alignment: Alignment(0, 0),
              image: new NetworkImage(this.urlofimage),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
