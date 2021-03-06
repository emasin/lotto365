// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';

abstract class PuzzleControls implements Listenable {
  void reset();

  int get clickCount;

  int get num1;
  int get num2;
  int get num3;
  int get num4;
  int get num5;
  int get num6;
  int get type;

  String get btnText;

  int get incorrectTiles;

  bool get autoPlay;

  void Function(bool newValue) get setAutoPlayFunction;
}
