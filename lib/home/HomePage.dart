import 'package:flutter/material.dart';
import 'package:lotto365/FadePageRoute.dart';
import 'package:lotto365/home/GradientAppBar.dart';
import 'package:lotto365/src/core/puzzle_animator.dart';
import 'package:lotto365/src/puzzle_home.dart';
import 'package:lotto365/src/puzzle_home_state.dart';
import 'package:lotto365/src/core/puzzle_animator.dart';
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        new GradientAppBar("Lotto365"),
        new Container(child: GestureDetector(child: Text('생성'),onTap: () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PuzzleHome(3,3)),
          );

        },),)

      ],
    );
  }
}






