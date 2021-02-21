// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:bingolotto45/db_helper.dart';
import 'package:bingolotto45/home/LottoNumberList.dart';
import 'package:bingolotto45/model/LottoNumber.dart';

import 'core/puzzle_proxy.dart';
import 'flutter.dart';
import 'puzzle_controls.dart';
import 'widgets/material_interior_alt.dart';
import 'puzzle_home_state.dart';

final puzzleAnimationDuration = kThemeAnimationDuration * 3;

abstract class SharedTheme {

  const SharedTheme();

  String get name;

  int get type;

  Color get puzzleThemeBackground;

  RoundedRectangleBorder puzzleBorder(bool small);

  Color get puzzleBackgroundColor;

  Color get puzzleAccentColor;

  EdgeInsetsGeometry tilePadding(PuzzleProxy puzzle) => const EdgeInsets.all(6);

  Widget tileButton(int i, PuzzleProxy puzzle, bool small);

  Ink createInk(
    Widget child, {
    DecorationImage image,
    EdgeInsetsGeometry padding,
  }) =>
      Ink(
        padding: padding,
        decoration: BoxDecoration(
          image: image,
        ),
        child: child,
      );

  Widget createButton(
    PuzzleProxy puzzle,
    bool small,
    int tileValue,
    Widget content, {
    Color color,
    RoundedRectangleBorder shape,
  }) =>
      AnimatedContainer(
        duration: puzzleAnimationDuration,
        padding: tilePadding(puzzle),
        child: RaisedButton(
          elevation: 4,
          clipBehavior: Clip.hardEdge,
          animationDuration: puzzleAnimationDuration,
          onPressed: () => puzzle.clickOrShake(tileValue),
          shape: shape ?? puzzleBorder(small),
          padding: const EdgeInsets.symmetric(),
          child: content,
          color: color,
        ),
      );

  // Thought about using AnimatedContainer here, but it causes some weird
  // resizing behavior
  Widget styledWrapper(bool small, Widget child) => MaterialInterior(
        duration: puzzleAnimationDuration,
        shape: puzzleBorder(small),
        color: puzzleBackgroundColor,
        child: child,
      );

  TextStyle get _infoStyle => TextStyle(
      color: puzzleAccentColor, fontWeight: FontWeight.bold, fontSize: 14);

  List<Widget> bottomControls(PuzzleControls controls) => <Widget>[
        IconButton(
          onPressed: controls.reset,
          icon: Icon(Icons.refresh, color: puzzleAccentColor),
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          controls.num1.toString(),
          textAlign: TextAlign.right,
          style: _infoStyle,
        ),
        const Text(','),
        Text(
          controls.num2.toString(),
          textAlign: TextAlign.right,
          style: _infoStyle,
        ),
        const Text(','),
        Text(
          controls.num3.toString(),
          textAlign: TextAlign.right,
          style: _infoStyle,
        ),
        const Text(','),
        Text(
          controls.num4.toString(),
          textAlign: TextAlign.right,
          style: _infoStyle,
        ),
        const Text(','),
        Text(
          controls.num5.toString(),
          textAlign: TextAlign.right,
          style: _infoStyle,
        ),
        const Text(','),
        Text(
          controls.num6.toString(),
          textAlign: TextAlign.right,
          style: _infoStyle,
        ),
        const Text(' '),
        FlatButton(
            splashColor: puzzleAccentColor,
            color: puzzleAccentColor,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {
              List<int> nlist = List<int>();
              nlist.add(controls.num1);
              nlist.add(controls.num2);
              nlist.add(controls.num3);
              nlist.add(controls.num4);
              nlist.add(controls.num5);
              nlist.add(controls.num6);

              nlist.sort();
              print(nlist);
              print(type);
              LottoNumber bb = new LottoNumber(
                num1: nlist[0],
                num2: nlist[1],
                num3: nlist[2],
                num4: nlist[3],
                num5: nlist[4],
                num6: nlist[5],
                type : type
              );

              DBHelper().addNumber(bb);
              showInterstitialAd();


              LottoNumberList.scaffoldKey.currentState.setState(() {
                Navigator.of(LottoNumberList.scaffoldKey.currentContext).pop();
              });

            },
            child: Text(
              controls.btnText.toString(),
            ))
      ];

  void showInterstitialAd() async {
    if (await PuzzleHomeState.interstitialAd.isLoaded) {
      PuzzleHomeState.interstitialAd.show();
    }
  }
  Widget tileButtonCore(int i, PuzzleProxy puzzle, bool small) {
    if (i == puzzle.tileCount && !puzzle.solved) {
      return const Center();
    }

    return tileButton(i, puzzle, small);
  }
}
