import 'package:ball_python_calc/GeneticPair.dart';
import 'package:ball_python_calc/Morph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Genetic.dart';
import 'MorphListWidget.dart';

void main() {
  Genetic.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ボールパイソンモルフ計算 (BallPython Morph Calculator)'),
    );
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GeneticPair> Males = [];
  List<GeneticPair> Females = [];

  @override
  Widget build(BuildContext context) {
    var MaleList=MorphListWidget(AddMale);
    var FemaleList=MorphListWidget(AddFemale);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: 300,
                  height: 150,
                  margin: EdgeInsets.all(10),
                  child: MaleList,
                ),
              ),
              Expanded(
                child: Container(
                  width: 300,
                  height: 150,
                  margin: EdgeInsets.all(10),
                  child: FemaleList,
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.

              children: [
                Expanded(
                  child: Container(
                    width: 300,
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) {
                        MaleList.search!(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "オス",
                        hintText: "空欄でノーマル",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 300,
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) {
                        FemaleList.search!(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "オス",
                        hintText: "空欄でノーマル",
                      ),
                    ),
                  ),
                ),
              ]),
          Container(
              margin: EdgeInsets.only(top: 10),
              width: 150,
              height: 80,
              child: ElevatedButton(
                  onPressed: () {
                    var maleStr = "オス:";
                    if (!listEquals(Males, <GeneticPair>[])) {
                      Males.forEach((element) {
                        maleStr += element.toString() + ",";

                      });
                      maleStr = maleStr.substring(0, maleStr.length - 1);
                    } else {
                      maleStr += "ノーマル";
                    }
                    var femaleStr = "メス:";
                    if (!listEquals(Females, <GeneticPair>[])) {
                      Females.forEach((element) {
                        femaleStr += element.toString() + ",";


                      });
                      femaleStr = femaleStr.substring(0, femaleStr.length - 1);
                    } else {
                      femaleStr += "ノーマル";
                    }
                    setState(() {
                      MixStr = maleStr + " X " + femaleStr;
                    });

                    Morph.Calc(Males, Females);
                  },
                  child: Text(
                    "計算",
                    style: new TextStyle(
                      fontSize: 30.0,
                    ),
                  ))),
          Text(MixStr)
        ],
      ),
    );
  }

  String MixStr = "";

  void AddMale(GeneticPair a) {
    print(a);
    if (!Males.contains(a)) {
      setState(() {
        Males.add(a);
      });

    }
  }

  void AddFemale(GeneticPair a) {
    print(a);
    if (!Females.contains(a)) {
      setState(() {
        Females.add(a);
      });

    }
  }
}
