// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:bingolotto45/src/const.dart';

import 'core/puzzle_proxy.dart';
import 'flutter.dart';
import 'shared_theme.dart';

const _yellowIsh = Color.fromARGB(255, 248, 244, 233);
const _chocolate = Color(0xff00704A);
const _orangeIsh = Color(0xff00704A);

class ThemePlaster extends SharedTheme {
  @override
  String get name => 'Starbucks Ball';

  @override
  int get type => 1;

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
          color: Color.fromARGB(255, 5, 5, 5),
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(small ? 24 : 24),
        ),
      );


  @override
  Widget tileButton(int i, PuzzleProxy puzzle, bool small) {
    if (i == puzzle.tileCount) {
      assert(puzzle.solved);
      return const Center(
        child: Icon(
          Icons.thumb_up,
          size: 72,
          color: _orangeIsh,
        ),
      );
    }

    final correctPosition = puzzle.isCorrectPosition(i);
    final decorationImage =new DecorationImage(
      image: new AssetImage('asset/sb_icon${Random().nextInt(3)+1}.jpg'),
      fit: BoxFit.cover,
    );
    final content = createInk(
      puzzle.solved
          ? const Center()
          : Container(
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: correctPosition ? Colors.black38 : Color.fromARGB(1, 90, 135, 170),
        ),
        alignment: Alignment.center,
        child: Text(
          (i + 1).toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: correctPosition ? Colors.black : Colors.black87,
            fontSize: small ? 16 : 40,
          ),
        ),
      ),
      image: decorationImage,

    );

    return createButton(
      puzzle,
      small,
      i,
      content,
      color: const Color(0xff061993),
    );
  }
}
