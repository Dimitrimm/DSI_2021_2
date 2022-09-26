import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Startup Name Generator', home: MainPage());
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
  final _lovedOnes = <WordPair>[];
  String _viewType = "list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(child: _body()),
      floatingActionButton: FloatingActionButton(
          onPressed: _setNewViewState,
          child: Icon(_viewType == "list" ? Icons.grid_view : Icons.list)),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text('Startup Name Generator'),
      actions: _actionButton(),
    );
  }

  _actionButton() {
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

  _body() {
    if (_viewType == "list") {
      return _listView(_lovedOnes);
    } else {
      return _gridView(_lovedOnes);
    }
  }

  _listView(List<WordPair> lovedOnes) {
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
            trailing: SizedBox(
                width: 100,
                child: Row(children: [
                  IconButton(
                      onPressed: () {
                        _suggestions.removeAt(index);
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete_outline)),
                  IconButton(
                      onPressed: () {
                        if (lovedOnes.contains(_suggestions[index])) {
                          lovedOnes.remove(_suggestions[index]);
                        } else {
                          lovedOnes.add(_suggestions[index]);
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        lovedOnes.contains(_suggestions[index])
                            ? Icons.thumb_up_alt_rounded
                            : Icons.thumb_up_alt_outlined,
                        color: Colors.blue[900],
                      ))
                ])));
      },
    );
  }

  _gridView(List<WordPair> lovedOnes) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        /*3*/
        if (i >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return Card(
            borderOnForeground: true,
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: Stack(children: [
                  Center(
                    child: Text(
                      _suggestions[i].asPascalCase,
                      style: _biggerFont,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          if (lovedOnes.contains(_suggestions[i])) {
                            lovedOnes.remove(_suggestions[i]);
                          } else {
                            lovedOnes.add(_suggestions[i]);
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          lovedOnes.contains(_suggestions[i])
                              ? Icons.thumb_up_alt_rounded
                              : Icons.thumb_up_alt_outlined,
                          color: Colors.blue[900],
                        )),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        _suggestions.removeAt(i);
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete_outline),
                    ),
                  )
                ])));
      },
    );
  }
}
