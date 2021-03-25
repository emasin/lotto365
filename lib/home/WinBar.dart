import 'dart:async';

import 'package:bingolotto45/function.dart';
import 'package:bingolotto45/home/LottoNumberList.dart';
import 'package:bingolotto45/src/const.dart';
import 'package:bingolotto45/src/flutter.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:bingolotto45/Theme.dart' as Theme;
import 'package:bingolotto45/model/Planet.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
class WinBar extends StatelessWidget {
  Completer<http.Response> _responseCompleter = new Completer();
  Map<String, dynamic> json_data;
  WinBar(this.json_data);
  @override
  Widget build(BuildContext context) {


    if ( !_responseCompleter.isCompleted) {
      _responseCompleter.complete(http.get('http://www.devkids.co.kr/win.json'));

    }
    const _orangeIsh = Color.fromARGB(255, 224, 107, 83);
//FDE2AE 1
//8CC6E7 10
//F18D80 20
//A7A1DE 30
//6BCE9E 40

    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      margin: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + 36.0, child:
    new Container(
      margin: EdgeInsets.only(top: 5),
      child:
      new Column(

        children: [

          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text(json_data['cnt'].toString(), style: new TextStyle( fontSize: 20.0,color: Colors.red)),
              new Text("회차 당첨번호 "),
              new Text(json_data['date'], style: new TextStyle( fontSize: 20.0))
            ],),
          new SizedBox(height: 5,),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Container(
                margin: EdgeInsets.only(right: 3),
                alignment: Alignment.center,
                width: 30.0,
                height: 30.0,
                padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: getLessColor(json_data['no1']),
                ),
                child: new Text(json_data['no1'].toString(), style: new TextStyle(color: Colors.white, fontSize: 12.0)),// You can add a Icon instead of text also, like below.
                //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
              ),
              new Container(
                margin: EdgeInsets.only(right: 3),
                alignment: Alignment.center,
                width: 30.0,
                height: 30.0,
                padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: getLessColor(json_data['no2']),
                ),
                child: new Text(json_data['no2'].toString(), style: new TextStyle(color: Colors.white, fontSize: 12.0)),// You can add a Icon instead of text also, like below.
                //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
              ),
              new Container(
                margin: EdgeInsets.only(right: 3),
                alignment: Alignment.center,
                width: 30.0,
                height: 30.0,
                padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: getLessColor(json_data['no3']),
                ),
                child: new Text(json_data['no3'].toString(), style: new TextStyle(color: Colors.white, fontSize: 12.0)),// You can add a Icon instead of text also, like below.
                //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
              ),
              new Container(
                margin: EdgeInsets.only(right: 3),
                alignment: Alignment.center,
                width: 30.0,
                height: 30.0,
                padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: getLessColor(json_data['no4']),
                ),
                child: new Text(json_data['no4'].toString(), style: new TextStyle(color: Colors.white, fontSize: 12.0)),// You can add a Icon instead of text also, like below.
                //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
              ),
              new Container(
                margin: EdgeInsets.only(right: 3),
                alignment: Alignment.center,
                width: 30.0,
                height: 30.0,
                padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: getLessColor(json_data['no5']),
                ),
                child: new Text(json_data['no5'].toString(), style: new TextStyle(color: Colors.white, fontSize: 12.0)),// You can add a Icon instead of text also, like below.
                //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
              ),
              new Container(
                margin: EdgeInsets.only(right: 5),
                alignment: Alignment.center,
                width: 30.0,
                height: 30.0,
                padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: getLessColor(json_data['no6']),
                ),
                child: new Text(json_data['no6'].toString(), style: new TextStyle(color: Colors.white, fontSize: 12.0)),// You can add a Icon instead of text also, like below.
                //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
              ),
              new Text('+ 보너스 번호'),
              new Container(
                alignment: Alignment.center,
                width: 30.0,
                height: 30.0,
                margin: EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: getLessColor(json_data['bno']),

                ),
                child: new Text(json_data['bno'].toString(), style: new TextStyle(color: Colors.white, fontSize: 12.0)),// You can add a Icon instead of text also, like below.
                //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
              ),

            ],)
        ],),),) ;
  }
 

  }


