import 'package:admob_flutter/admob_flutter.dart';
import 'package:bingolotto45/db_helper.dart';
import 'package:bingolotto45/function.dart';
import 'package:bingolotto45/home/LottoNumberList.dart';
import 'package:bingolotto45/home/WinBar.dart';
import 'package:bingolotto45/model/LottoNumber.dart';
import 'package:flutter/material.dart';
import 'package:bingolotto45/FadePageRoute.dart';
import 'package:bingolotto45/home/GradientAppBar.dart';
import 'package:bingolotto45/src/core/puzzle_animator.dart';
import 'package:bingolotto45/src/puzzle_home.dart';
import 'package:bingolotto45/src/puzzle_home_state.dart';
import 'package:bingolotto45/src/core/puzzle_animator.dart';
import 'package:unicorndial/unicorndial.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {


    var childButtons = List<UnicornButton>();




    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "모두 지워버리고 다시 시작!",
        currentButton: FloatingActionButton(
          heroTag: "deleteAll",
          backgroundColor: Colors.amberAccent,
          mini: false,
          child: Icon(Icons.auto_delete),
          onPressed: () {
            LottoNumberList.scaffoldKey.currentState.setState(() {
              DBHelper().clearNumbers();
            });

          },
        )));


    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "TikTok추천볼",
        currentButton: FloatingActionButton(
          heroTag: "TikTok",
          backgroundColor: Colors.cyanAccent,
          mini: false,
          child: Icon(Icons.title),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PuzzleHome(9,5,4)),
            );

          },
        )));


    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "내 인생 전부를 걸고",
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: Colors.orangeAccent,
          mini: false,
          child: Icon(Icons.circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PuzzleHome(9,5,2)),
            );
          },
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "큰 기대 없이 그냥 ",
        currentButton: FloatingActionButton(
            heroTag: "airplane",
            backgroundColor: Colors.blueAccent,
            mini: false,
            child: Icon(Icons.circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PuzzleHome(9,5,1)),
            );
          },)));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "머니 머니 해도 머니",
        currentButton: FloatingActionButton(
            heroTag: "directions",
            backgroundColor: Colors.black,
            mini: false,
            child: Icon(Icons.money),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PuzzleHome(9,5,3)),
            );
          },)));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "GoldenBall",
        currentButton: FloatingActionButton(
          heroTag: "GoldenBall",
          backgroundColor: Colors.yellow,
          mini: false,
          child: Icon(Icons.circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PuzzleHome(9,5,0)),
            );
          },)));
    return new Scaffold(
        floatingActionButton :UnicornDialer(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
            parentButtonBackground: Colors.pinkAccent,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.bubble_chart_outlined),
            childButtons: childButtons),
      body: new HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => new _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {

  Completer<http.Response> _responseCompleter = new Completer();

  @override
  Widget build(BuildContext context) {
    if (!_responseCompleter.isCompleted) {
      _responseCompleter.complete(
          http.get('http://www.devkids.co.kr/win.json'));
    }

    return

      new FutureBuilder(
          future: _responseCompleter.future,
          builder: (BuildContext context,
              AsyncSnapshot<http.Response> response) {
            if (!response.hasData) {
              return const Center(
                child: const Text('Loading...'),
              );
            } else if (response.data.statusCode != 200) {
              return const Center(
                child: const Text('Error loading data'),
              );
            } else {
              Map<String, dynamic> json_data = json.decode(response.data.body);
              LottoNumber.server_data = json_data;
              print("except numbers ${LottoNumber.server_data['except']}");

              return new Column(
                children: <Widget>[
                  new GradientAppBar("AI 추천 로또45"),
                  //new Container(child: Text("당신의 행운 번호는?"),)
                  new WinBar(json_data),
                  new LottoNumberList(json_data)

                ],
              );
            }
          }
      );
  }
}






