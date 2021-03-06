import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Genetic.dart';
import 'GeneticPair.dart';
import 'Morph.dart';
import 'MorphListWidget.dart';
import 'OverlayLoading.dart';

void main() {
  Genetic.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ボールパイソン遺伝計算',
      theme: ThemeData(
        fontFamily: 'OpenSans',
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
      home: MyHomePage(title: 'ボールパイソン遺伝計算'+(kIsWeb?"(低速)":"")),
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
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                            labelText: "メス",
                            hintText: "空欄でノーマル",
                          ),
                        ),
                      ),
                    ),
                  ]),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.

                  children: [
                    Expanded(
                      child: Container(
                        width: 300,
                        height: 50,
                        margin: EdgeInsets.all(10),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 8.0,
                          runSpacing: 0.0,
                          direction: Axis.horizontal,
                          children: GetChip(Males),
                        ),
                      ),
                    ),
                    /*  Expanded(
                      child: Container(
                          width: 300,
                          height: 150,
                          margin: EdgeInsets.all(10),
                          child: ListView.builder(
                            itemCount: Males.length,
                            itemBuilder: (context, index) {
                              return Chip(
                                label: Text(Males[index].toString()),
                                onDeleted: () {
                                  setState(() {
                                    Males.removeAt(index);
                                  });
                                },
                              );
                            },
                          )),
                    ),*/
                    Expanded(
                      child: Container(
                        width: 300,
                        height: 50,
                        margin: EdgeInsets.all(10),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 8.0,
                          runSpacing: 0.0,
                          direction: Axis.horizontal,
                          children: GetChip(Females),
                        ),
                      ),
                    ),
                    /*Expanded(
                      child: Container(
                        width: 300,
                        margin: EdgeInsets.all(10),
                        child:
                      ),
                    ),*/
                  ]),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 150,
                  height: 80,
                  child: ElevatedButton(
                      onPressed: () async {
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
                          femaleStr =
                              femaleStr.substring(0, femaleStr.length - 1);
                        } else {
                          femaleStr += "ノーマル";
                        }


                        if (kIsWeb) {

                          compute(Morph.Calc, Tuple3(null, Males, Females))
                              .then((value) {
                            setState(() {
                              CalcResult = value;
                            });
                          }).whenComplete(() {
                            setState(() {
                              isCalculating = false;
                            });
                          });
                          setState(() {
                            MixStr = maleStr + " × " + femaleStr;
                            isCalculating = true;
                          });
                        }else{
                          ReceivePort receivePort = ReceivePort();
                          receivePort.listen((message) {
                            setState(() {
                              CalcResult = message is List<Tuple2<String, double>>
                                  ? message
                                  : null;
                              isCalculating = false;
                            });
                          });
                          var iso= await Isolate.spawn(Morph.Calc,
                              Tuple3(receivePort.sendPort, Males, Females));
                          setState(() {
                            MixStr = maleStr + " × " + femaleStr;
                            isCalculating = true;
                            isolate=iso;
                          });
                          ReceivePort deletePort = ReceivePort();
                          deletePort.listen((message) {
                            setState(() {
                              isolate=null;
                              if(isCalculating)  CalcResult =null;
                              isCalculating = false;

                            });
                          });
                          isolate!.addOnExitListener(deletePort.sendPort);
                        }

                      },
                      child: Text(
                        "計算",
                        style: new TextStyle(
                          fontSize: 30.0,
                        ),
                      ))),
              Text(
                MixStr,
                style: TextStyle(fontSize: 20),
              ),
              isCalculating
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.lightBlueAccent)),
                ],
              )
                  : GetTable(),
            ],
          ),
        ),
        OverlayLoading(visible: isCalculating, isolate: isolate),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _launchURL("https://github.com/unity709/Ball_Python_Genetic_Calc"),
        child: Icon(Icons.info_outline),
      ),
    );
  }

  Isolate? isolate;
  bool isCalculating = false;

  void _launchURL(String url) async =>
      await canLaunch(url)
          ? await launch(url, enableJavaScript: true)
          : throw 'Could not launch $url';
  List<Tuple2<String, double>>? CalcResult;

  DataTable GetTable() {
    return DataTable(
      columns: [
        DataColumn(
          label: Text("名前"),
        ),
        DataColumn(
          label: Text("確率(百分率)"),
        ),
        DataColumn(
          label: Text("確率(分数)"),
        ),
      ],
      rows: GetRow(),
    );
  }

  List<DataRow> GetRow() {
    List<DataRow> result = [];
    if (CalcResult != null) {
      for (var i = 0; i < CalcResult!.length; i++) {
        var e = CalcResult![i];
        result.add(DataRow(cells: [
          DataCell(Text(e.item1)),
          DataCell(Text((e.item2 * 100).toString() + "%")),
          DataCell(Text(Fraction.fromDouble(e.item2).reduce().toString())),
        ]));
      }
    } else {}
    return result;
  }

  ListView GetResult() {
    return ListView.builder(
      itemCount: CalcResult!.length + 1,
      itemBuilder: (context, index) {
        var i = index - 1;
        if (i == -1) {
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(child: Container(width: 100, child: Text("名前"))),
            Expanded(child: Container(width: 100, child: Text("確率(百分率)"))),
            Expanded(
              child: Container(width: 100, child: Text("確率(分数)")),
            ),
          ]);
        }
        var e = CalcResult![i];
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(child: Container(width: 100, child: Text(e.item1))),
          Expanded(
              child: Container(
                  width: 100, child: Text((e.item2 * 100).toString() + "%"))),
          Expanded(
            child: Container(
                width: 100,
                child: Text(Fraction.fromDouble(e.item2).reduce().toString())),
          ),
        ]);
      },
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

  List<Chip> GetChip(List list) {
    List<Chip> result = [];
    for (int i = 0; i < list.length; i++) {
      result.add(Chip(
          label: Text(list[i].toString()),
          onDeleted: () {
            setState(() {
              list.removeAt(i);
            });
          }));
    }
    return result;
  }

  void AddFemale(GeneticPair a) {
    print(a);
    if (!Females.contains(a)) {
      setState(() {
        Females.add(a);
      });
    }
  }

  late MorphListWidget MaleList;
  late MorphListWidget FemaleList;

  @override
  void initState() {
    MaleList = MorphListWidget(AddMale);
    FemaleList = MorphListWidget(AddFemale);
  }
}
