import 'package:flutter/foundation.dart';

import 'Genetic.dart';

class GeneticPair {
  List<Genetic> pair = [];

  Info info = Info.None;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneticPair &&
          runtimeType == other.runtimeType &&
          listEquals(pair, other.pair)&&info==other.info;

  @override
  int get hashCode => pair.hashCode;

  GeneticPair.auto(Genetic a, {Info info = Info.None}) {
    pair=[a,Genetic.normal];
    this.info=info;
    switch (a.order) {
      case Order.Recessive:
        if(info!=Info.Het){
          pair[1]=a;
        }
        break;
      case Order.Dominance:

        break;
      case Order.CoDominance:
        if(info==Info.Super){
          pair[1]=a;
        }
        break;
      case Order.Normal:
        throw Exception("不正");
        break;
    }
  }

  GeneticPair.normal() {
    this.pair = [Genetic.normal, Genetic.normal];
  }

  GeneticPair(Genetic a, Genetic b) {
    if (a.ID != 0 && b.ID != 0 && a.ID != b.ID) {
      throw new Exception("不可能な組み合わせ");
    }
    this.pair = [a, b];
    switch (pair[0].order) {
      case Order.Recessive:
        if (pair[1].order == Order.Normal) {
          info = Info.Het;
        }
        break;
      case Order.Dominance:
        break;
      case Order.CoDominance:

        if (pair[1].ID == pair[0].ID) {
          info = Info.Super;
        }
        break;
      case Order.Normal:
        break;
    }
  }

  List<int> ToIntList() {
    return [pair[0].ID, pair[1].ID];
  }

  static GeneticPair ToGeneticPairFromID(List<int> ids) {
    return GeneticPair(Genetic.fromID(ids[0]), Genetic.fromID(ids[1]));
  }

  @override
  String toString() {
    var str="";
      switch (info) {

        case Info.None:
          str+=pair[0].toString();
          break;
        case Info.Het:
          str+="ヘテロ "+pair[0].toString();
          break;
        case Info.Super:
          str+="スーパー "+pair[0].toString();
          break;
      }
    if (str=="") {
      str="ノーマル";
    }
    return str;
  }
}

enum Info {
  None,
  Het,
  Super,
}
