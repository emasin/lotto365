import 'package:flutter/material.dart';
import 'package:bingolotto45/Theme.dart' as Theme;
import 'package:shimmer/shimmer.dart';

class GradientAppBar extends StatelessWidget {

  final String title;
  final double barHeight = 66.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [  new Center(
        child: Shimmer.fromColors(
          baseColor: Color(0xFFF147DB),
          highlightColor: const Color(0xFF86E732),
          child: Text(
            '$title        ',
            textAlign: TextAlign.center,
            style: Theme.TextStyles.appBarTitle,
          ),
        ), /**new Text(
            title,
            style: Theme.TextStyles.appBarTitle,
            )**/

      ),new SizedBox(),],) ,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Theme.Colors.appBarGradientStart, Theme.Colors.appBarGradientEnd],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.5, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp
        ),
      ),
    );
  }
}