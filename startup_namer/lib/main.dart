import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/wordpair_repo.dart';

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
  final _suggestionsRepo = WordPairRepo();
  final _biggerFont = const TextStyle(fontSize: 18);
  final _lovedOnes = <WordPair>[];
  String _viewType = "list";

  @override
  void initState() {
    super.initState();
  }

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
    List<WordPair> suggestions = _suggestionsRepo.namesList;
    List<Widget> cardsList = <Widget>[];
    for (WordPair i in suggestions) {
      cardsList.add(Card(
          elevation: 2,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: const EdgeInsets.all(25),
                child: Text(i.asPascalCase, style: _biggerFont)),
            Row(children: [
              IconButton(
                  onPressed: () {
                    suggestions.remove(i);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete_outline)),
              IconButton(
                  onPressed: () {
                    if (lovedOnes.contains(i)) {
                      lovedOnes.remove(i);
                    } else {
                      lovedOnes.add(i);
                    }
                    setState(() {});
                  },
                  icon: Icon(
                    lovedOnes.contains(i)
                        ? Icons.thumb_up_alt_rounded
                        : Icons.thumb_up_alt_outlined,
                    color: Colors.blue[900],
                  ))
            ])
          ])));
    }
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: cardsList,
    );
  }

  _gridView(List<WordPair> lovedOnes) {
    List<Widget> cardsList = <Widget>[];
    List<WordPair> suggestions = _suggestionsRepo.namesList;
    for (WordPair i in suggestions) {
      cardsList.add(Card(
          borderOnForeground: true,
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: Stack(children: [
                Center(
                  child: Text(
                    i.asPascalCase,
                    style: _biggerFont,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        if (lovedOnes.contains(i)) {
                          lovedOnes.remove(i);
                        } else {
                          lovedOnes.add(i);
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        lovedOnes.contains(i)
                            ? Icons.thumb_up_alt_rounded
                            : Icons.thumb_up_alt_outlined,
                        color: Colors.blue[900],
                      )),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      suggestions.remove(i);
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                )
              ]))));
    }
    return GridView(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      padding: const EdgeInsets.all(16.0),
      children: cardsList,
    );
  }
}
