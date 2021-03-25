// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'core/puzzle_proxy.dart';
import 'flutter.dart';
import 'shared_theme.dart';
import 'widgets/decoration_image_plus.dart';

class ThemeTiktok extends SharedTheme {
  @override
  String get name => 'TikTok Ball';

  @override
  int get type => 4;

  const ThemeTiktok();

  @override
  Color get puzzleThemeBackground => const Color.fromARGB(1, 90, 135, 170);

  @override
  Color get puzzleBackgroundColor => Colors.black12;

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

    final decorationImage1 =new DecorationImage(
      image: new AssetImage('asset/ttb1.png'),
      fit: BoxFit.cover,
    );

    final decorationImage2 =new DecorationImage(
      image: new AssetImage('asset/ttb2.png'),
      fit: BoxFit.cover,
    );

    final decorationImage3 =new DecorationImage(
      image: new AssetImage('asset/ttb3.png'),
      fit: BoxFit.cover,
    );

    final decorationImage4 =new DecorationImage(
      image: new AssetImage('asset/ttb4.png'),
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
                color: correctPosition ? Colors.black38 : Colors.white10,
              ),
              alignment: Alignment.center,
              child: Text(
                (i + 1).toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: correctPosition ? Colors.red : i%4==0 ? Colors.white : i%3==0 ?Colors.redAccent : i%2==0 ? Colors.cyanAccent : Colors.white,
                  fontSize: small ? 20 : 40,
                ),
              ),
            ),
      image: i%4==0? decorationImage4 : (i%3==0 ? decorationImage3 : (i%2==0 ? decorationImage2 : decorationImage1) ),

    );

    return createButton(puzzle, small, i, content);
  }
}
