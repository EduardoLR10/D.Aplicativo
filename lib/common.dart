import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({this.name: 'default', this.image});
  final String name, image;

  @override
  MyDrawerState createState() => MyDrawerState(name: name, image: image);
}

class MyDrawerState extends State<MyDrawer>{
  MyDrawerState({this.name,@required this.image});
  final String name, image;

  @override
  Widget build(BuildContext context) {
    return Drawer (
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 304.0,
                height: 172.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  color: Color(0xff88c9bf),
                  boxShadow: [BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0.0,
                      1.0,
                    ),
                  )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.symmetric(vertical: 10),),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 104,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 64,
                            width: 64,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(image),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child:
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),),
                            Container(
                              alignment: Alignment.centerLeft,
                              constraints: BoxConstraints(minWidth: 234,maxHeight: 48),
                              child: TextTopics(name),
                            ),
                            Icon(Icons.expand_more, size: 24,
                              color: Color(0xff757575),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TopicCont(text: 'Atalhos', color: 0xfffee29b, iconData: Icons.pets, iconColor: 0xff434343,),
              TopicCont(text: 'Informações', color: 0xffcfe9e5, iconData: Icons.info,),
              TopicCont(text: 'Configurações', color: 0xffe6e7e8, iconData: Icons.settings,),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xff88c9bf),
                  ),
                  child: TextTopics('Sair'),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class TextTopics extends StatelessWidget {
  TextTopics(this.string);

  final String string;

  @override
  Widget build(BuildContext context) {
    return Text (
      string,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Robotto',
        fontWeight: FontWeight.w500,
        color: Color(0xff434343),
        fontSize: 14.0,
      ),
    );
  }
}

class TopicCont extends StatelessWidget {
  TopicCont({this.text: 'default', this.color, this.iconData, this.iconColor: 0xff757575});

  final IconData iconData;
  final String text;
  final int color, iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:
        Container(
          alignment: Alignment.centerLeft,
          height: 48,
            decoration: BoxDecoration(
            color: Color(color),
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),),
              Icon(iconData, color: Color(iconColor), size: 24,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),),
              Container(
                alignment: Alignment.centerLeft,
                constraints: BoxConstraints(minWidth: 178,maxHeight: 48),
                child: TextTopics(text),
              ),
              Icon(Icons.expand_more, size: 24,
                  color: Color(0xff757575),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),),
            ],
          ),
        ),
    );
  }
}