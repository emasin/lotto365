import 'dart:async';

import 'package:bingolotto45/function.dart';
import 'package:bingolotto45/home/LottoNumberList.dart';
import 'package:bingolotto45/src/const.dart';
import 'package:bingolotto45/src/flutter.dart';
import 'package:bingolotto45/src/puzzle_home.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:bingolotto45/Theme.dart' as Theme;
import 'package:bingolotto45/model/Planet.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
class CommandBar extends StatelessWidget {
  CommandBar();
  @override
  Widget build(BuildContext context) {


    return
    new Container(child:  new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 2,),
        Expanded(
          flex: 1,
          child: Container(
            height: 80.0,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzleHome(9,5,0)),
                );
              },

              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [ Color(0xffFF9000),Color(0xffFF6600),],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(1.0)
                ),
                child: Container(

                  child:Column(children: [Image.asset('asset/scouter.jpeg',fit:BoxFit.fitHeight,),
                    Text(
                        "Dragon \nBall",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffFFFFFF),fontSize: 10
                        ))

                  ])
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 2,),
        Expanded(
          flex: 1,
          child: Container(
            height: 80.0,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzleHome(9,5,3)),
                );
              },

              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [ Color(0xff110100),Color(0xff1A0200),],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(1.0)
                ),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                    child:Column(children: [Image.asset('asset/4eyes.gif',fit:BoxFit.fitHeight,),
                      Text(
                          "寫輪眼\n사륜안",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xffFFFFFF),fontSize: 10
                          ))

                    ])
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 2,),
        Expanded(
          flex: 1,
          child: Container(
            height: 80.0,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzleHome(9,5,1)),
                );
              },

              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [ Color(0xffED1C24), Color(0xff004AAD),],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(1.0)
                ),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Super Ball",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 2,),
        Expanded(
          flex: 1,
          child: Container(
            height: 80.0,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzleHome(9,5,2)),
                );
              },

              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [ Color(0xffFFFFFF),Color(0xff00704A),],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(1.0)
                ),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Starbucks Edition",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black87
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 2,),
        Expanded(
          flex: 1,
          child: Container(
            height: 80.0,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzleHome(9,5,4)),
                );
              },

              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [ Color(0xff69C9D0),Color(0xff010101), Color(0xffEE1D52),],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(1.0)
                ),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "TikTok Edition",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 2,),
      ],) ,height: 80,padding: EdgeInsets.only(bottom:0.0),)
      ;
  }


}


