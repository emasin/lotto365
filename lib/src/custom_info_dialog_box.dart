import 'dart:math';
import 'dart:ui';

import 'package:bingolotto45/db_helper.dart';
import 'package:bingolotto45/function.dart';
import 'package:bingolotto45/home/LottoNumberList.dart';
import 'package:bingolotto45/model/LottoNumber.dart';
import 'package:bingolotto45/src/constants.dart';
import 'package:bingolotto45/src/puzzle_home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

class CustomInfoDialogBox extends StatefulWidget {
  static int size = 1;

  final String title, descriptions, text1;
  final Image img;


  const CustomInfoDialogBox({Key key, this.title, this.descriptions, this.text1,this.img}) : super(key: key);

  @override
  _CustomInfoDialogBoxState createState() => _CustomInfoDialogBoxState();
}

class _CustomInfoDialogBoxState extends State<CustomInfoDialogBox> {


  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String appName = packageInfo.packageName;

    return "로또45  ver. $version";
  }

  @override
  Widget build(BuildContext context) {


    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }



  contentBox(context){



    int m = Random().nextInt(6);
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              FutureBuilder(
                future: getVersionNumber(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                    Text(
                      snapshot.hasData ? snapshot.data : widget.descriptions,
                      style: TextStyle(fontSize: 20),textAlign: TextAlign.center,
                    ),
              ),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(widget.text1,style: TextStyle(fontSize: 18),)),

                ],) ,
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("asset/model${m+1}.png")
            ),
          ),
        ),
      ],
    );
  }
}