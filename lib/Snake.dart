import 'package:flutter/foundation.dart';
import 'Alias.dart';
import 'GeneticPair.dart';

class Snake {
  ///遺伝子
  List<List<int>> GeneticsPairs = [];

  void Add(GeneticPair genetics) {
    GeneticsPairs.add(genetics.ToIntList());
  }

  List<GeneticPair> pairs = [];

  void ToGenetic() {
    pairs.clear();
    GeneticsPairs.forEach((element) {
      var it = GeneticPair.ToGeneticPairFromID(element);
      pairs.add(it);
    });
  }

  void AddfromID(List<int> value) {
    value.sort((b, a) => a.compareTo(b));
    GeneticsPairs.add(value);
  }

  @override
  String toString() {
    ToGenetic();
    /* return 'Snake{GeneticsPairs: $pairs}';*/
    var str = '';
    var tmp = [...pairs];
    tmp.sort((a, b) => a.pair[0].ID.compareTo(b.pair[0].ID));
    tmp.forEach((element) {
      switch (element.info) {
        case Info.None:
          str += element.pair[0].toString();
          break;
        case Info.Het:
          str += "ヘテロ " + element.pair[0].toString();
          break;
        case Info.Super:
          str += "スーパー " + element.pair[0].toString();
          break;
      }

      if (element.pair[0].toString() != "") str += " ";
    });

    if (str == "") {
      str = "ノーマル";
    } else {
      str = str.substring(0, str.length - 1);
    }

    Alias.aliasList.containsKey(str);
    return Alias.aliasList.containsKey(str.replaceAll(" ", ""))? Alias.aliasList[str.replaceAll(" ", "")]: str;
  }




  @override
  bool operator ==(Object other) {
    bool tmp = identical(this, other) ||
        other is Snake &&
            runtimeType == other.runtimeType &&
            this.GeneticsPairs.length == other.GeneticsPairs.length;
    if (other is Snake && tmp) {
      bool result = true;
      for (int i = 0; i < this.GeneticsPairs.length; i++) {
        result = result
            ? listEquals(this.GeneticsPairs[i], other.GeneticsPairs[i])
            : false;
      }
      return result;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => GeneticsPairs.hashCode;
}
