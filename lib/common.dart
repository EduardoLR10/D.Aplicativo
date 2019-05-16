import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

var user;

class MyDrawer extends StatefulWidget {
  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  String name, image;

  @override
  initState() {
    super.initState();
    doAsyncStuff();
    name = '';
    image = '';
  }

  doAsyncStuff() async {
    user = await _auth.currentUser();
    FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser == null) {
      setState(() {
        this.name = 'No User Logged';
        this.image =
            'https://firebasestorage.googleapis.com/v0/b/meau-f8464.appspot.com/o/user.png?alt=media&token=0bdeed97-d9a1-4536-9e9b-7aa09da64e15';
      });
    } else {
      setState(() {
        this.name = currentUser.displayName;
        this.image = currentUser.photoUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    boxShadow: [
                      BoxShadow(
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 104,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 64,
                              width: 64,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    alignment: Alignment(0, 0),
                                    image: new NetworkImage(
                                        (this.image != null) ? this.image : ''),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 48,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                constraints: BoxConstraints(
                                    minWidth: 234, maxHeight: 48),
                                child: TextTopics(
                                    (this.name != null) ? this.name : ''),
                              ),
                              Icon(
                                Icons.expand_more,
                                size: 24,
                                color: Color(0xff757575),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TopicCont(
                  text: 'Meus Pets',
                  color: 0xffe6e7e8,
                  iconData: Icons.pets,
                  iconColor: 0xff434343,
                ),
                TopicCont(
                  text: 'Informações',
                  color: 0xffe6e7e8,
                  iconData: Icons.info,
                ),
                TopicCont(
                  text: 'Configurações',
                  color: 0xffe6e7e8,
                  iconData: Icons.settings,
                ),
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
          }),
    );
  }
}

class TextTopics extends StatelessWidget {
  TextTopics(this.string);

  final String string;

  @override
  Widget build(BuildContext context) {
    return Text(
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
  TopicCont(
      {this.text: 'default',
      this.color,
      this.iconData,
      this.iconColor: 0xff757575});

  final IconData iconData;
  final String text;
  final int color, iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FirebaseUser currentUser = await _auth.currentUser();
        if (currentUser == null) {
          Navigator.pushNamed(context, 'LOGINPAGE');
        } else {
          Navigator.pushNamed(context, 'MYPETSPAGE');
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 48,
        decoration: BoxDecoration(
          color: Color(color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
            Icon(
              iconData,
              color: Color(iconColor),
              size: 24,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            Container(
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(minWidth: 178, maxHeight: 48),
              child: TextTopics(text),
            ),
            Icon(
              Icons.expand_more,
              size: 24,
              color: Color(0xff757575),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ],
        ),
      ),
    );
  }
}
