String toCamelCase(String str) {
  RegExp exp = RegExp(
      r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+');
  Iterable<Match> matches = exp.allMatches(str);
  if (matches.isEmpty) return '';
  String res = '';
  for (Match m in matches) {
    String? match = m.group(0);
    if (match == null) {
      throw 'unexpected mismatch';
    }
    res +=
        match.substring(0, 1).toUpperCase() + match.substring(1).toLowerCase();
  }
  return res.substring(0, 1).toLowerCase() + res.substring(1);
}

String capitalize(String str) {
  if (str.isEmpty) {
    return str;
  }
  return str.substring(0, 1).toUpperCase() + str.substring(1);
}

String generateName(String raw) {
  return capitalize(toCamelCase(raw));
}
