import 'package:english_words/english_words.dart';

class WordPairRepo {
  List<WordPair> namesList = <WordPair>[];

  WordPairRepo() {
    namesList.addAll(generateWordPairs().take(20));
  }
}
