import 'package:admob_flutter/admob_flutter.dart';
import 'package:bingolotto45/db_helper.dart';
import 'package:bingolotto45/function.dart';
import 'package:bingolotto45/home/CommandBar.dart';
import 'package:bingolotto45/home/LottoNumberList.dart';
import 'package:bingolotto45/home/WinBar.dart';
import 'package:bingolotto45/model/LottoNumber.dart';
import 'package:bingolotto45/src/custom_info_dialog_box.dart';
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

import 'package:package_info/package_info.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }



  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }



  @override
  Widget build(BuildContext context) {

    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "clean all",
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
        labelText: "version ${_packageInfo.version}",
        currentButton: FloatingActionButton(
          heroTag: "info",
          backgroundColor: Colors.blueAccent,
          mini: false,
          child: Icon(Icons.info_outline_rounded),
          onPressed: () {
            showDialog(context: LottoNumberList.scaffoldKey.currentContext,
                builder: (BuildContext context){
                  return CustomInfoDialogBox(
                    title: "앱 정보",
                    descriptions: "${_packageInfo.version}",
                    text1: "확인",


                  );
                }
            );

          },
        )));
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
    var url = Uri.parse('http://www.devkids.co.kr/win.json');
    if (!_responseCompleter.isCompleted) {
      _responseCompleter.complete(
          http.get(url));
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

                  new WinBar(json_data),
                  new GradientAppBar(""),
                  new SizedBox(height: 5,),
                  new CommandBar(),
                  new LottoNumberList(json_data)

                ],
              );
            }
          }
      );
  }
}






