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
import 'package:store_launcher/store_launcher.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;


class CustomDialogBox extends StatefulWidget {
  static int size = 1;
  static int type = 1;
  final String title, descriptions, text1,text2;
  final Image img;
  final List list;
  static var except_no;
  const CustomDialogBox({Key key, this.title, this.descriptions, this.text1,this.text2, this.img,this.list}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
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


  void showInterstitialAd() async {
    if (await PuzzleHomeState.interstitialAd.isLoaded) {
      PuzzleHomeState.interstitialAd.show();
    }
  }

  contentBox(context){


    String desc = "";
    LottoNumber  ln1 = widget.list[0];
    desc = "${ln1.num1},${ln1.num2},${ln1.num3},${ln1.num4},${ln1.num5},${ln1.num6}\n";
    if( CustomDialogBox.size == 5) {
      LottoNumber ln2 = widget.list[1];
      LottoNumber ln3 = widget.list[2];
      LottoNumber ln4 = widget.list[3];
      LottoNumber ln5 = widget.list[4];


      desc = desc + "${ln2.num1},${ln2.num2},${ln2.num3},${ln2.num4},${ln2.num5},${ln2.num6}\n"
          + "${ln3.num1},${ln3.num2},${ln3.num3},${ln3.num4},${ln3.num5},${ln3.num6}\n"
          + "${ln4.num1},${ln4.num2},${ln4.num3},${ln4.num4},${ln4.num5},${ln4.num6}\n"
          + "${ln5.num1},${ln5.num2},${ln5.num3},${ln5.num4},${ln5.num5},${ln5.num6}\n";

    }

    int m = Random().nextInt(6);
    print('widget.type ${CustomDialogBox.type}');
    if(CustomDialogBox.type ==0) {
      m = 6;
    }else if(CustomDialogBox.type ==3) {
      m = 7;
    }else if(CustomDialogBox.type ==1) {
      m = 8;
    }

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
              SizedBox(height: 10,),
              Text(desc,style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              CustomDialogBox.type == 3 ? Text('사륜안만 보이는 제외번호',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),) :SizedBox(height: 0,),
              CustomDialogBox.type == 3 ? Text(CustomDialogBox.except_no.toString(),style: TextStyle(fontSize: 14),textAlign: TextAlign.center,) :SizedBox(height: 0,),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.yellow,
                  height: 150,
                  child: ClipRect(
                      child:GestureDetector(child: Banner(
                        message: "hello",
                        location: BannerLocation.topEnd,
                        color: Colors.red,
                        child: Container(
                          color: Colors.yellow,
                          height: 150,
                          width: 217,
                          child: Center(
                            child: Image.asset('asset/150banner.png'),
                          ),
                        ),
                      ),onTap: () {
                        openWithStore();
                      },)
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(widget.text1,style: TextStyle(fontSize: 18),)),
                  FlatButton(
                      onPressed: (){

                        if(CustomDialogBox.size == 5)
                          showInterstitialAd();

                        for(int i = 0; i < widget.list.length;i++) {
                          DBHelper().addNumber(widget.list[i]);
                        }
                        LottoNumberList.scaffoldKey.currentState.setState(() {
                          //Navigator.of(LottoNumberList.scaffoldKey.currentContext).pop();
                          Navigator.of(LottoNumberList.scaffoldKey.currentContext).pop();
                          Navigator.of(LottoNumberList.scaffoldKey.currentContext).pop();
                        });
                      },
                      child: Text(widget.text2,style: TextStyle(fontSize: 18),)),
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

  Future<void> openWithStore() async {
    var appId = TargetPlatform.iOS == Theme.of(context).platform ? '1551638920' : 'kr.co.devkids.apps.flagmaster.flagmaster';
    print('app id: $appId');
    try {
      StoreLauncher.openWithStore(appId).catchError((e) {
        print('ERROR> $e');
      });
    } on Exception catch (e) {
      print('$e');
    }
  }
}