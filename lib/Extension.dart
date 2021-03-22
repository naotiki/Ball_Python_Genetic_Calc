import 'GeneticPair.dart';

class Extension {
  // Enumの値を文字列として扱えるようにする(あとで解説)
  static String enumToString(value) {
    return value.toString().split('.')[1];
  }

}
/*
/// Dart きらい しね Kotlinのほうが1.00E+99倍いい
extension ContainList on List<List<int>> {
  bool containsSecondElement(List<int> b, [List<int>? deny]) {
    for (List<int> e in this) {
      if (listEquals(e, b) || e[0] == b[0]) {
        if (deny == null) {
          return true;
        }
        if (!(b== deny)) {
          return true;
        }
      }
    }
    return false;
  }

  int indexOfSecondElement(List<int> b, [List<int>? deny]) {
    for (var i = 0; i < this.length; i++) {
      if (listEquals(this[i], b) || this[i][0] == b[0]) {
        if (deny == null) {
          return i;
        }
        if (!(b== deny)) {
          return i;
        }
      }
    }

    return -1;
  }
}*/
extension StringEx on String{
   String kanaToHira() {
    return this.replaceAllMapped(new RegExp("[ァ-ヴ]"), (Match m) => String.fromCharCode(m.group(0)!.codeUnitAt(0) - 0x60));
  }
   String hiraToKana() {
     return this.replaceAllMapped(new RegExp("[ぁ-ゔ]"), (Match m) => String.fromCharCode(m.group(0)!.codeUnitAt(0) + 0x60));
   }
}
extension GeneticsList on List<GeneticPair> {
  int indexOfGeneticPairs(GeneticPair b,Set<int> deny) {
    var r=-1;
    for (var i = 0; i < this.length; i++) {

      if (this[i].pair[0].ID == b.pair[0].ID&&this[i].hashCode!=b.hashCode&&!deny.contains(this[i])) {
        r=i;
        if(this[i].pair[1].ID == b.pair[1].ID){
          return r;
        }

      }
    }

    return r;
  }
}
