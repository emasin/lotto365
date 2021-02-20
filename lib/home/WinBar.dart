import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:bingolotto45/Theme.dart' as Theme;
import 'package:bingolotto45/model/Planet.dart';


class WinBar extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
 
    return new Container(
      height: 130,
      child: Column(

        children: [
          Text("951회차 당첨번호",style: TextStyle(

              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              fontSize: 24.0
          ),),
          Image.asset("asset/210220.jpeg")
        ],
      ),);
  }
 

  }


