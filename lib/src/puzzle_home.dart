// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'core/puzzle_animator.dart';
import 'flutter.dart';
import 'puzzle_home_state.dart';


class PuzzleHome extends StatefulWidget {
  final int _rows, _columns;

  const PuzzleHome(this._rows, this._columns);

  @override
  PuzzleHomeState createState() =>
      PuzzleHomeState(PuzzleAnimator(_columns, _rows));
}
