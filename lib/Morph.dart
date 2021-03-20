import 'dart:math';

import 'package:tuple/tuple.dart';

import 'Extension.dart';
import 'GeneticPair.dart';
import 'Snake.dart';

/// # モルフを定義するクラス
class Morph {
  ///短縮形 Clacにバイパス
  static void CalcDebug(GeneticPair male ,GeneticPair female) =>Calc([male], [female]);
  static void Calc(List<GeneticPair> Male, List<GeneticPair> Female) {
    print(Male);
    print(Female);
    var male = Snake();
    var female = Snake();
    Male.forEach((element) {
      male.Add(element);
    });
    Female.forEach((element) {
      female.Add(element);
    });

    ///同じ遺伝子同士のペア
    ///For Example:[  1ペア->[[1,0],[1,0]] ,2ペア->[ [2,2],[2,2] ] ]  ]
    /// - ジェネリクスで頭おかしくなりそう
    /// なんだよ 3次元配列じゃねーか
    /// わー　にじいろできれいだなー
    /// LOOK:https://youtu.be/ZEcrvX4wrj4
    List<List<List<int>>> pair = [];

    print(male.GeneticsPairs);
    print(female.GeneticsPairs);

    male.GeneticsPairs.forEach((element) {
      //スーパーでも一緒になるようにする
      if (female.GeneticsPairs.containsSecondElement(element)) {
        var i = female.GeneticsPairs.indexOfSecondElement(element);
        pair.add([element, female.GeneticsPairs[i]]);
        female.GeneticsPairs.removeAt(i);
      } else {
        pair.add([
          element,
          [0, 0]
        ]);
      }
    });
    female.GeneticsPairs.forEach((element) {
      pair.add([
        element,
        [0, 0]
      ]);
    });

    int all = pair.length*4;// pow(pair.length, 4).toInt();
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
        for (int i2 = 0; i2 < all / pow(4, i1 + 1).toInt(); i2++) {
          //何回繰り返す?
          children[index].AddfromID(groups[groupIndex]);
          index++;
        }
        groupIndex++;
        if (groupIndex >= 4) groupIndex = 0;
      }
    }

    List<Tuple2<String,double>> result =[];
     var morphs=new Set();
    var morphAll=[];
    children.forEach((element) {
      morphs.add(element.toString());
      morphAll.add(element.toString());
      //print(element);
    });
    morphs.forEach((element) {
      result.add(new Tuple2(element, 1/morphs.length));


    });

    print(result.toString());

  }
}
