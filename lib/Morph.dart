import 'dart:isolate';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

import 'Extension.dart';
import 'Genetic.dart';
import 'GeneticPair.dart';
import 'Snake.dart';

/// # モルフを定義するクラス
class Morph {
  static Future<List<Tuple2<String, double>>> Calc(
      Tuple3<SendPort?, List<GeneticPair>, List<GeneticPair>> snakes
      /* List<GeneticPair> Male, List<GeneticPair> Female*/) async {
    Genetic.initialize();
    var Male = snakes.item2;
    var Female = snakes.item3;
    if (listEquals(Male, [])) {
      Male = [GeneticPair.normal()];
    }
    if (listEquals(Female, [])) {
      Female = [GeneticPair.normal()];
    }

    var male = Snake();
    var female = Snake();
    Male.forEach((element) {
      male.Add(element);
    });
    Female.forEach((element) {
      female.Add(element);
    });
    male.ToGenetic();
    female.ToGenetic();

    ///同じ遺伝子同士のペア
    ///For Example:[  1ペア->[[1,0],[1,0]] ,2ペア->[ [2,2],[2,2] ] ]  ]
    /// - ジェネリクスで頭おかしくなりそう
    /// なんだよ 3次元配列じゃねーか
    /// わー　にじいろできれいだなー
    /// LOOK:https://youtu.be/ZEcrvX4wrj4
    List<List<List<int>>> pair = [];

    print(male.GeneticsPairs);
    print(female.GeneticsPairs);
    Set<int> denyHashList = new Set<int>();
    male.pairs.forEach((element) {
      if (denyHashList.contains(element.hashCode)) {
        return;
      } else {
        denyHashList.add(element.hashCode);
        var fi = female.pairs.indexOfGeneticPairs(element, denyHashList);
        if (fi != -1) {
          pair.add([element.ToIntList(), female.pairs[fi].ToIntList()]);
          denyHashList.add(female.pairs[fi].hashCode);
        } else {
          var index = male.pairs.indexOfGeneticPairs(element, denyHashList);
          if (index != -1) {
            pair.add([element.ToIntList(), male.pairs[index].ToIntList()]);
            denyHashList.add(male.pairs[index].hashCode);
          } else {
            pair.add([
              element.ToIntList(),
              [0, 0]
            ]);
          }
        }
      }
    });

    female.pairs.forEach((element) {
      if (denyHashList.contains(element.hashCode)) {
        return;
      } else {
        denyHashList.add(element.hashCode);
        var index = female.pairs.indexOfGeneticPairs(element, denyHashList);
        if (index != -1) {
          pair.add([element.ToIntList(), female.pairs[index].ToIntList()]);
          denyHashList.add(female.pairs[index].hashCode);
        } else {
          pair.add([
            element.ToIntList(),
            [0, 0]
          ]);
        }
      }
    });
    if (pair.length != 1) {
      pair = pair.where((element) => !listEquals(element[0], [0, 0])).toList();
    }

    int all = pow(
      4,
      pair.length,
    ).toInt();
    List<Snake> children = [];
    for (int i2 = 0; i2 < all; i2++) {
      children.add(new Snake());
    }
    print(pair);

    for (int i1 = 0; i1 < pair.length; i1++) {
      var group = pair[i1];
      List<List<int>> groups = [
        [group[0][0], group[1][0]],
        [group[0][0], group[1][1]],
        [group[0][1], group[1][0]],
        [group[0][1], group[1][1]],
      ];

      var groupIndex = 0;
      for (int index = 0; index < all;) {
        for (int i2 = 0; i2 < (all / pow(4, i1 + 1).toInt()); i2++) {
          //何回繰り返す?
          children[index].AddfromID(groups[groupIndex]);
          index++;
        }
        groupIndex++;
        if (groupIndex >= 4) groupIndex = 0;
      }
    }

    List<Tuple2<String, double>> result = [];
    var morphs = new Set();
    var morphAll = [];
    children.forEach((element) {
      morphs.add(element.toString());
      morphAll.add(element.toString());
      //print(element);
    });
    morphs.forEach((element) {
      var i = morphAll.where((element1) => element == element1).length;
      result.add(new Tuple2(element, i / morphAll.length));
    });

    print(result.toString());
    snakes.item1?.send(result);
    return Future<List<Tuple2<String, double>>>.value(result);
  }
}
