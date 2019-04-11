import 'package:flutter/material.dart';
import './assets/images.dart';
//Import necessário para rodar meu app
import 'package:english_words/english_words.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MainPage(),
  ));
}

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
    return Scaffold(
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
                heroTag: "btn1",
                child: new Text("Enter"),
                onPressed: () {
                  print("Loading...");
                  setState(() {
                    _click = false;
                  });
                },
              ),
              FloatingActionButton(
                heroTag: "btn2",
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
              ),
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
                    new MaterialPageRoute(builder: (context) => new TestStateLess()),
                  );
                },
              ),
      ),
    );
  }
}

class TestStateLess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Mudou para azul!"),
        backgroundColor: Colors.red,
      ),
      body: new Center(
        child: new Text("Estou testando"),
      ),
    );
  }
}



void second_main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primeiro_Flutter Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 20.0);
  Widget _buildSuggestions(){
    return ListView.builder(padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context,i){
          if(i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if(index >= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        } );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Text('Primeiro_Flutter Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context){
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair){
              return new ListTile(
                title: new Text(pair.asPascalCase,style: _biggerFont,),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(context: context, tiles: tiles,)
              .toList();
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }


}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
