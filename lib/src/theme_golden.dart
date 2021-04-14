// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'core/puzzle_proxy.dart';
import 'flutter.dart';
import 'shared_theme.dart';
import 'widgets/decoration_image_plus.dart';

class ThemeGolden extends SharedTheme {
  @override
  String get name => 'Golden Ball';

  @override
  int get type => 2;

  const ThemeGolden();

  @override
  Color get puzzleThemeBackground => const Color.fromARGB(1, 90, 135, 170);

  @override
  Color get puzzleBackgroundColor => Colors.white24;

  @override
  Color get puzzleAccentColor => const Color(0xff000000);

  @override
  RoundedRectangleBorder puzzleBorder(bool small) =>
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      );

  @override
  EdgeInsetsGeometry tilePadding(PuzzleProxy puzzle) =>
      puzzle.solved ? const EdgeInsets.all(1) : const EdgeInsets.all(4);

  @override
  Widget tileButton(int i, PuzzleProxy puzzle, bool small) {
    if (i == puzzle.tileCount && !puzzle.solved) {
      assert(puzzle.solved);
    }

    final decorationImage =new DecorationImage(
      image: new AssetImage('asset/bitcoin.jpg'),
      fit: BoxFit.cover,
    );

    final correctPosition = puzzle.isCorrectPosition(i);
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
                  color: correctPosition ? Colors.black : Colors.white,
                  fontSize: small ? 14 : 28,
                ),
              ),
            ),
      image: decorationImage,

    );

    return createButton(puzzle, small, i, content);
  }
}
