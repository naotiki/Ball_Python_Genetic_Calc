import 'dart:isolate';

import 'package:flutter/material.dart';

//
// 全面表示のローディング
//
class OverlayLoading extends StatelessWidget {
  OverlayLoading({required this.visible,required this.isolate});

  //表示状態
  final bool visible;
final Isolate? isolate;
  @override
  Widget build(BuildContext context) {
    return visible
        ? Container(
            decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.white)),
                Text("計算中",style: new TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                )),
                Container(
                  padding: EdgeInsets.only(top: 75),
                  child: ElevatedButton(style: new ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),

                      onPressed: (){
                    isolate!.kill(priority: Isolate.immediate);
                   //isolate!.kill(priority: Isolate.immediate);
                  }, child: Text("キャンセル")),
                )
              ],
            ),
          )
        : Container();
  }
}
