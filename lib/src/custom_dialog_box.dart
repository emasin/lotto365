import 'dart:ui';

import 'package:bingolotto45/home/LottoNumberList.dart';
import 'package:bingolotto45/src/constants.dart';
import 'package:bingolotto45/src/puzzle_home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  static int size = 1;
  final String title, descriptions, text1,text2;
  final Image img;

  const CustomDialogBox({Key key, this.title, this.descriptions, this.text1,this.text2, this.img}) : super(key: key);

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
              Text(widget.descriptions,style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
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
                        print("size ${CustomDialogBox.size}");
                        //DBHelper().addNumber(bb);
                        if(CustomDialogBox.size == 5)
                          showInterstitialAd();

                        LottoNumberList.scaffoldKey.currentState.setState(() {
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
                child: Image.asset("asset/model.jpeg")
            ),
          ),
        ),
      ],
    );
  }
}