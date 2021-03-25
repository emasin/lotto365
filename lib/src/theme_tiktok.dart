// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'core/puzzle_proxy.dart';
import 'flutter.dart';
import 'shared_theme.dart';
import 'widgets/decoration_image_plus.dart';

class ThemeTiktok extends SharedTheme {
  @override
  String get name => 'TikTok';

  @override
  int get type => 2;

  const ThemeTiktok();

  @override
  Color get puzzleThemeBackground => const Color.fromARGB(153, 90, 135, 170);

  @override
  Color get puzzleBackgroundColor => Colors.white70;

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
      image: new AssetImage('asset/tiktok.png'),
      fit: BoxFit.cover,
    );


    //Image.asset('asset/tiktok.jpg',width: puzzle.width.toDouble(),height: puzzle.height.toDouble(),);
    /** DecorationImagePlus(
        puzzleWidth: puzzle.width,
        puzzleHeight: puzzle.height,
        fit: BoxFit.cover,
        image: const AssetImage('asset/tiktok.jpg'));
**/
    final correctPosition = puzzle.isCorrectPosition(i);
    final content = createInk(
      puzzle.solved
          ? const Center()
          : Container(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: correctPosition ? Colors.black38 : Colors.white54,
              ),
              alignment: Alignment.center,
              child: Text(
                (i + 1).toString(),
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: correctPosition ? Colors.black : Colors.black,
                  fontSize: small ? 20 : 40,
                ),
              ),
            ),
      image: decorationImage,

    );

    return createButton(puzzle, small, i, content);
  }
}
