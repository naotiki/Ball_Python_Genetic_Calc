import 'package:flutter/foundation.dart';

class Extension {
  // Enumの値を文字列として扱えるようにする(あとで解説)
  static String enumToString(value) {
    return value.toString().split('.')[1];
  }
}

/// Dart きらい しね Kotlinのほうが1.00E+99倍いい
extension ContainList on List<List<int>> {
  bool containsSecondElement(List<int> b) {
    for (List<int> e in this) {
      if (listEquals(e, b)||e[0]== b[0]) return true;
    }
    return false;
  }

  int indexOfSecondElement(List<int> b) {
    for (var i = 0; i < this.length; i++) {
      if (listEquals(this[i], b)) {
        return i;
      }
      if (this[i][0]== b[0]) {
        return i;
      }
    }

    return -1;
  }
}
