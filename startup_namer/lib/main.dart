import 'package:flutter/material.dart';
import 'package:startup_namer/update.dart';
import 'package:startup_namer/wordpair_mod.dart';
import 'package:startup_namer/wordpair_repo.dart';

void main() {
  runApp(MaterialApp(
    title: 'Startup Name Generator',
    initialRoute: 'home',
    routes: {
      'home': (context) => const MainPage(),
      'update': (context) => const UpdateView()
    },
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late WordPairRepo _suggestionsRepo;
  final _biggerFont = const TextStyle(fontSize: 18);
  String _viewType = "list";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      _suggestionsRepo =
          ModalRoute.of(context)!.settings.arguments as WordPairRepo;
    } catch (e) {
      _suggestionsRepo = WordPairRepo();
    }
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
      return _listView();
    } else {
      return _gridView();
    }
  }

  _listView() {
    List<WordPairMod> suggestions = _suggestionsRepo.namesList;
    List<Widget> cardsList = <Widget>[];
    for (WordPairMod i in suggestions) {
      cardsList.add(GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'update',
                arguments: <dynamic>[_suggestionsRepo, suggestions.indexOf(i)]);
          },
          child: Card(
              elevation: 2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(25),
                        child: Text(i.getPairString(), style: _biggerFont)),
                    Row(children: [
                      IconButton(
                          onPressed: () {
                            suggestions.remove(i);
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete_outline)),
                      IconButton(
                          onPressed: () {
                            if (i.isloved) {
                              i.isloved = false;
                            } else {
                              i.isloved = true;
                            }
                            setState(() {});
                          },
                          icon: Icon(
                            i.isloved
                                ? Icons.thumb_up_alt_rounded
                                : Icons.thumb_up_alt_outlined,
                            color: Colors.blue[900],
                          ))
                    ])
                  ]))));
    }
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: cardsList,
    );
  }

  _gridView() {
    List<Widget> cardsList = <Widget>[];
    List<WordPairMod> suggestions = _suggestionsRepo.namesList;
    for (WordPairMod i in suggestions) {
      cardsList.add(GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'update',
                arguments: <dynamic>[_suggestionsRepo, suggestions.indexOf(i)]);
          },
          child: Card(
              borderOnForeground: true,
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Stack(children: [
                    Center(
                      child: Text(
                        i.getPairString(),
                        style: _biggerFont,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            if (i.isloved) {
                              i.isloved = false;
                            } else {
                              i.isloved = true;
                            }
                            setState(() {});
                          },
                          icon: Icon(
                            i.isloved
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
                  ])))));
    }
    return GridView(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      padding: const EdgeInsets.all(16.0),
      children: cardsList,
    );
  }
}
