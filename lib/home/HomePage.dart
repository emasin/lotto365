import 'package:bingolotto45/home/PlanetList.dart';
import 'package:flutter/material.dart';
import 'package:bingolotto45/FadePageRoute.dart';
import 'package:bingolotto45/home/GradientAppBar.dart';
import 'package:bingolotto45/src/core/puzzle_animator.dart';
import 'package:bingolotto45/src/puzzle_home.dart';
import 'package:bingolotto45/src/puzzle_home_state.dart';
import 'package:bingolotto45/src/core/puzzle_animator.dart';
import 'package:unicorndial/unicorndial.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "내 인생 전부를 걸고",
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: Colors.orangeAccent,
          mini: true,
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
            mini: true,
            child: Icon(Icons.circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PuzzleHome(9,5,1)),
            );
          },)));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "내 인생에 명품 하나쯤은",
        currentButton: FloatingActionButton(
            heroTag: "directions",
            backgroundColor: Colors.black,
            mini: true,
            child: Icon(Icons.shopping_bag),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PuzzleHome(9,5,3)),
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


  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new GradientAppBar("BINGO LOTTO 45"),
        //new Container(child: Text("당신의 행운 번호는?"),)
        new PlanetList()

      ],
    );
  }
}






