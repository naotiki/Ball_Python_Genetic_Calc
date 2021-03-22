import 'dart:io';
import 'Extension.dart';
import 'package:ball_python_calc/Genetic.dart';
import 'package:ball_python_calc/GeneticPair.dart';
import 'package:flutter/material.dart';

class MorphListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_MorphListWidgetState();


  void Function(String a)? search;

  MorphListWidget(this.Add);

  final void Function(GeneticPair) Add;
}

// Stateを継承して使う
class _MorphListWidgetState extends State<MorphListWidget> {


  // データを元にWidgetを作る
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: showButtons.length,
      itemBuilder: (context, index) {
        return showButtons[index];
      },
    );
  }

  List<TextButton> showButtons=[];
  void Search(String str){

    setState(() {

      showButtons= allButtons.where((element) {
        return (element.child as Text).data!.kanaToHira().toLowerCase().contains(str.kanaToHira().toLowerCase())
            ||(element.child as Text).data!.hiraToKana().toLowerCase().contains(str.hiraToKana().toLowerCase());
      }
      ).toList();
    });
  }


  List<TextButton> allButtons = [];

  void CreateButtons() {
    allButtons.clear();
    var list = [...Genetic.genetics];
    list.sort((a, b) => a.name.compareTo(b.name));
    list.forEach((element) {
      if (element.ID != 0) {
        //ノーマルじゃないなら
        allButtons.add(TextButton(
            onPressed: () => widget.Add(GeneticPair.auto(element)),
            child: Text(element.name)));
        if (element.order == Order.CoDominance) {
          allButtons.add(TextButton(
              onPressed: () => widget.Add(GeneticPair.auto(element, info: Info.Super)),
              child: Text("スーパー " + element.name)));
        } else if (element.order == Order.Recessive) {
          allButtons.add(TextButton(
              onPressed: () => widget.Add(GeneticPair.auto(element, info: Info.Het)),
              child: Text("ヘテロ " + element.name)));
        }
      }
    });
  }

  @override
  void initState() {
    widget.search=Search;
    CreateButtons();
    setState(() {
      showButtons=[...allButtons];
    });

  }
}
