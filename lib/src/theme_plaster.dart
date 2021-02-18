// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:lotto365/src/const.dart';

import 'core/puzzle_proxy.dart';
import 'flutter.dart';
import 'shared_theme.dart';

const _yellowIsh = Color.fromARGB(255, 248, 244, 233);
const _chocolate = Color.fromARGB(255, 66, 66, 68);
const _orangeIsh = Color.fromARGB(255, 224, 107, 83);

class ThemePlaster extends SharedTheme {
  @override
  String get name => '핫 오렌지볼';

  const ThemePlaster();

  @override
  Color get puzzleThemeBackground => _chocolate;

  @override
  Color get puzzleBackgroundColor => _yellowIsh;

  @override
  Color get puzzleAccentColor => _orangeIsh;

  @override
  RoundedRectangleBorder puzzleBorder(bool small) => RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromARGB(255, 103, 103, 105),
          width: 8,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(small ? 10 : 18),
        ),
      );

  @override
  Widget tileButton(int i, PuzzleProxy puzzle, bool small) {
    final correctColumn = i % puzzle.width;
    final correctRow = i ~/ puzzle.width;

    final primary = (correctColumn + correctRow).isEven;

    if (i == puzzle.tileCount) {
      assert(puzzle.solved);
      return Center(
        child: Icon(
          Icons.thumb_up,
          size: small ? 50 : 72,
          color: _orangeIsh,
        ),
      );
    }

    final content = Text(
      (i + 1).toString(),
      style: TextStyle(
        color:  _yellowIsh ,
        fontFamily: 'Plaster',
        fontSize: small ? smallFontSize : largeFontSize,
      ),
    );

    return createButton(
      puzzle,
      small,
      i,
      content,
      color: _orangeIsh ,
      shape: RoundedRectangleBorder(
        side: BorderSide(color:  _orangeIsh, width: 5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
