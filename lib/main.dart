import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyRandomWordApp());

class MyRandomWordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title2 = 'Random Word';
    return MaterialApp(title: title2, home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordState();
}

class RandomWordState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();

  final _bigFont = TextStyle(fontSize: 18);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16),
        itemBuilder: (context, i) {
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          if (i.isOdd) {
            return Divider();
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair suggestion) {
    var alReadySaved = _saved.contains(suggestion);
    return ListTile(
      title: Text(
        suggestion.asPascalCase.toString(),
        style: _bigFont,
      ),
      leading: Icon(Icons.arrow_forward),
      trailing: Icon(alReadySaved ? Icons.favorite : Icons.favorite_border,
          color: Colors.red),
      onTap: () {
        setState(() {
          if (alReadySaved) {
            _saved.remove(suggestion);
          } else {
            _saved.add(suggestion);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('demo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.local_movies),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      var tiles = _saved.map((pair) {
        return ListTile(
            title: Text(
          pair.asPascalCase,
          style: _bigFont,
        ));
      });
      final divide =
          ListTile.divideTiles(tiles: tiles, context: context).toList();
      return new SavedPage(divide: divide);
    }));
  }
}

class SavedPage extends StatelessWidget {
  const SavedPage({
    Key key,
    @required this.divide,
  }) : super(key: key);

  final List<Widget> divide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Page'),
      ),
      body: ListView(
        children: divide,
      ),
    );
  }
}
