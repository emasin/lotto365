import 'package:flutter/material.dart';
import 'package:lotto365/Theme.dart' as Theme;
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
      child: new Center(
        child: Shimmer.fromColors(
          baseColor: Color(0xFF54C5E6),
          highlightColor: const Color(0xFFFF8C00),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.TextStyles.appBarTitle,
          ),
        ), /**new Text(
          title,
          style: Theme.TextStyles.appBarTitle,
        )**/

      ),
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