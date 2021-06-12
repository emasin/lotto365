// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:bingolotto45/src/const.dart';

import 'core/puzzle_proxy.dart';
import 'flutter.dart';
import 'shared_theme.dart';

const _accentBlue = Color(0xff000579e);
const _bgBlue = Color(0xff004AAD);

class ThemeSimple extends SharedTheme {
  @override
  String get name => '鬼滅の刃';

  @override
  int get type => 0;

  const ThemeSimple();

  @override
  Color get puzzleThemeBackground => const Color.fromARGB(1, 90, 135, 170);

  @override
  Color get puzzleBackgroundColor => Colors.white70;

  @override
  Color get puzzleAccentColor => const Color(0xff000000);

  @override
  RoundedRectangleBorder puzzleBorder(bool small) =>
      const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black87, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(18),
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
          color: _accentBlue,
        ),
      );
    }
    Random rdm = new Random();
    int star = rdm.nextInt(9);
    final correctPosition = puzzle.isCorrectPosition(i);
    final decorationImage =new DecorationImage(
      image: new AssetImage('asset/n$star.png'),
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
            fontSize: small ? 12 : 24,
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
