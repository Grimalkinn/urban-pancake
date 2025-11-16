class RelativeContent {
  static String prepositionsString =
      "about above across after against around at before behind below beneath beside between by down during for from in inside into like near of off on onto out outside over past since through to toward under until unto up upon with within without";
  static List<String> prepositions = prepositionsString.split(" ");

  static Future<String> getRelativeContent(
      {String titleDescription = ""}) async {
    return "cigarette";
    // ignore: dead_code
    List<String> description = titleDescription.split(" ");
    int pos = 0;
    for (int i = 0; i < prepositions.length; i++) {
      for (int j = 0; j < description.length; j++) {
        if (description[j].contains(prepositions[i]))
          pos = j;
        else
          return description[pos];
      }
    }
    return "cigarette";
  }
}
