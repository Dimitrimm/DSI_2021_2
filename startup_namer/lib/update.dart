import 'package:flutter/material.dart';
import 'package:startup_namer/wordpair_mod.dart';
import 'package:startup_namer/wordpair_repo.dart';

class UpdateView extends StatefulWidget {
  const UpdateView({Key? key}) : super(key: key);

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  var txc1 = TextEditingController();
  var txc2 = TextEditingController();
  late WordPairMod pairInUpdate;
  late WordPairRepo pairRepo;
  bool isUpdate = true;
  @override
  Widget build(BuildContext context) {
    try {
      final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
      pairRepo = args[0];
      pairInUpdate = pairRepo.namesList[args[1]];
      txc1.text = pairInUpdate.firstWord;
      txc2.text = pairInUpdate.secondWord;
    } catch (e) {
      pairRepo = ModalRoute.of(context)!.settings.arguments as WordPairRepo;
      isUpdate = false;
      txc1.text = '';
      txc2.text = '';
    }

    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text('Startup Name Generator'),
      automaticallyImplyLeading: true,
    );
  }

  Widget _body(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
              elevation: 2,
              color: Colors.grey.shade200,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: txc1,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Primeira palavra:'),
                  ))),
          Card(
              elevation: 2,
              color: Colors.grey.shade200,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: txc2,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Segunda palavra:'),
                  ))),
          GestureDetector(
              onTap: () {
                if (isUpdate) {
                  pairInUpdate.firstWord = txc1.text;
                  pairInUpdate.secondWord = txc2.text;
                } else {
                  pairRepo.namesList
                      .insert(0, WordPairMod(txc1.text, txc2.text));
                }
                Navigator.pushNamed(context, 'home', arguments: pairRepo);
              },
              child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 2,
                    color: Colors.grey.shade200,
                    child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: Text(
                          'Salvar!',
                          style: TextStyle(fontSize: 20),
                        ))),
                  )))
        ],
      ),
    );
  }
}
