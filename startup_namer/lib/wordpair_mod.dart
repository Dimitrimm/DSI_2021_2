class WordPairMod {
  String firstWord;
  String secondWord;
  bool isloved;

  WordPairMod(this.firstWord, this.secondWord) : isloved = false;

  getPairString() {
    return firstWord + secondWord;
  }
}
