import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Startup Name Generator',
      home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  String _viewType = "list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context), body: Center(child: _body(context)));
  }

  _appBar(BuildContext context) {
    return AppBar(
      title: const Text('Startup Name Generator'),
      actions: _actionButton(context),
    );
  }

  _actionButton(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: _setNewViewState,
        icon: Icon(_viewType == "list" ? Icons.grid_view : Icons.list),
      )
    ];
  }

  _setNewViewState() {
    if (_viewType == "list") {
      _viewType = "grid";
    } else {
      _viewType = "list";
    }
    setState(() {});
  }

  _body(BuildContext context) {
    if (_viewType == "list") {
      return _listView();
    } else {
      return _gridView();
    }
  }

  _listView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
  }

  _gridView() {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        ; /*3*/
        if (i >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return Card(
            borderOnForeground: true,
            child: Center(
              child: Text(
                _suggestions[i].asPascalCase,
                style: _biggerFont,
              ),
            ));
      },
    );
  }
}
