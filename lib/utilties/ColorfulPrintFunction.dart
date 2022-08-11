void printSuccess(dynamic elem) {
  final text = elem.toString();
  print('\x1B[32m$text\x1B[0m');
}

void printUnimportant(dynamic elem) {
  final text = elem.toString();
  print('\x1B[35m$text\x1B[0m');
}

void printFatel(dynamic elem) {
  final text = elem.toString();
  print('\x1B[31m$text\x1B[0m');
}

void printHighlight(dynamic elem) {
  final text = elem.toString();
  print('\x1B[33m$text\x1B[0m');
}
