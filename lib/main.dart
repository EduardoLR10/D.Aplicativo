import 'package:flutter/material.dart';
import './assets/images.dart';

void main() => runApp(MainPage());

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainState();
  }
}

class MainState extends State<MainPage> {
  var _click = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Desenvolvimento de Aplicativos"),
        ),
        floatingActionButton: Container(
          width: 335,
          height: 70,
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              child: new Text("Enter"),
              onPressed: () {
                print("Loading...");
                setState(() {
                  _click = false;
                });
              },
            ),
            FloatingActionButton(
              child: Icon(Icons.refresh, color: Colors.white),
              backgroundColor: Colors.red,
              onPressed: () {
                print("Loading...2");
                setState(() {
                  _click = true;
                });
              },
            ),
            Text("O Giordano \né desumilde"),
            Container(
              width: 50,
              height: 50,
              child: new Image.asset('assets/bluecircle.png'),
            )
          ],
        )),
        body: new Center(
          child: _click
              ? new CircularProgressIndicator()
              : new FlatButton(
                  child: new TestImageWidget("redcircle.png"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClickedState()),
                    );
                  }),
        ),
      ),
    );
  }
}

class ClickedState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Mudou para azul!"),
        backgroundColor: Colors.red,
      ),
      body: new Center(
        child: new FlatButton(
            child: new TestImageWidget("bluecircle.png"), onPressed: () {}),
      ),
    );
  }
}
