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

            color: Colors.amberAccent,
            height: 80,
            child:  OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzleHome(9,5,0)),
                );
              },
              child: Text("Golden Ball",style: TextStyle(color: Colors.black),),
            ),
          ),
        ),
        SizedBox(width: 2,),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.black,
            height: 80,
            child:  OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzleHome(9,5,3)),
                );
              },
              child: Text("Money Ball",style: TextStyle(color: Colors.yellowAccent),),
            ),
          ),
        ),
        SizedBox(width: 2,),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blueAccent,
            height: 80,
            child:  OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzleHome(9,5,1)),
                );
              },
              child: Text("Blue Ball",style: TextStyle(
                color: Colors.white,)),
            ),
          ),
        ),
        SizedBox(width: 2,),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.deepOrangeAccent,
            height: 80,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzleHome(9,5,2)),
                );
              },
              child: Text("Orange Ball",style: TextStyle(color: Colors.black),),
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


