// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' show Point, Random;

import 'package:bingolotto45/function.dart';
import 'package:bingolotto45/home/LottoNumberList.dart';
import 'package:bingolotto45/model/LottoNumber.dart';
import 'package:bingolotto45/model/comments.dart';
import 'package:bingolotto45/src/custom_dialog_box.dart';
import 'package:bingolotto45/src/flutter.dart';

import 'body.dart';
import 'puzzle.dart';
import 'puzzle_proxy.dart';

class PuzzleAnimator implements PuzzleProxy {
  final _rnd = Random();
  final List<Body> _locations;
  final _controller = StreamController<PuzzleEvent>();
  bool _nextRandomVertical = true;
  Puzzle _puzzle;
  int _clickCount = 0;

  int _num1=0;
  int _num2=0;
  int _num3=0;
  int _num4=0;
  int _num5=0;
  int _num6=0;
  String _btnText="?";
  int _type = 0;
  bool _stable;

  bool get stable => _stable;

  @override
  bool get solved => _puzzle.incorrectTiles == 0;

  @override
  int get width => _puzzle.width;

  @override
  int get height => _puzzle.height;

  @override
  int get length => _puzzle.length;

  @override
  int get tileCount => _puzzle.tileCount;

  int get incorrectTiles => _puzzle.incorrectTiles;

  int get clickCount => _clickCount;

  int get num1 => _num1;
  int get num2 => _num2;
  int get num3 => _num3;
  int get num4 => _num4;
  int get num5 => _num5;
  int get num6 => _num6;

  int get type => _type;

  String   get btnText => _btnText;

  void reset() => _resetCore();

  Stream<PuzzleEvent> get onEvent => _controller.stream;

  @override
  bool isCorrectPosition(int value) => _puzzle.isCorrectPosition(value);

  @override
  Point<double> location(int index) => _locations[index].location;

  int _lastBadClick;
  int _badClickCount = 0;

  PuzzleAnimator(int width, int height) : this._(Puzzle(width, height));

  PuzzleAnimator._(this._puzzle)
      : _locations = List.generate(_puzzle.length, (i) {
          return Body.raw(
              (_puzzle.width - 1.0) / 2, (_puzzle.height - 1.0) / 2, 0, 0);
        });

  void playRandom() {
    if (_puzzle.fitness == 0) {
      return;
    }

    _puzzle = _puzzle.clickRandom(vertical: _nextRandomVertical);
    _nextRandomVertical = !_nextRandomVertical;
    _clickCount++;
    _controller.add(PuzzleEvent.random);
  }

  @override
  void clickOrShake(int tileValue) {
    if (solved) {
      _controller.add(PuzzleEvent.noop);
      _shake(tileValue);
      _lastBadClick = null;
      _badClickCount = 0;
      return;
    }

    _controller.add(PuzzleEvent.click);
    if (!_clickValue(tileValue)) {
      _shake(tileValue);

      // This is logic to allow a user to skip to the end – useful for testing
      // click on 5 un-movable tiles in a row, but not the same tile twice
      // in a row
      if (tileValue != _lastBadClick) {
        _badClickCount++;
        if (_badClickCount >= 5) {
          // Do the reset!
          final newValues = List.generate(_puzzle.length, (i) {
            if (i == _puzzle.tileCount) {
              return _puzzle.tileCount - 1;
            } else if (i == (_puzzle.tileCount - 1)) {
              return _puzzle.tileCount;
            }
            return i;
          });
          _resetCore(source: newValues);
          _clickCount = 999;
        }
      } else {
        _badClickCount = 0;
      }
      _lastBadClick = tileValue;
    } else {
      _lastBadClick = null;
      _badClickCount = 0;
    }
  }


  void random(){
    _controller.add(PuzzleEvent.reset);
  }
  void _resetCore({List<int> source}) {
    //_puzzle = _puzzle.reset(source: source);
    _clickCount = 0;
    _lastBadClick = null;
    _badClickCount = 0;
    Timer _timer = new Timer.periodic(const Duration(milliseconds: 1000), (Timer timer) {
      _puzzle = _puzzle.reset(source: source);
      _controller.add(PuzzleEvent.reset);
      _clickCount++;


      if(_clickCount == 1)
        _num1 = _puzzle[0];

      if(_clickCount == 2)
        _num2 = _puzzle[0];

      if(_clickCount == 3)
        _num3 = _puzzle[0];

      if(_clickCount == 4)
        _num4 = _puzzle[0];

      if(_clickCount == 5)
        _num5 = _puzzle[0];

      if(_clickCount == 6)
        _num6 = _puzzle[0];

      if (_clickCount > 5) {
        Random rdm = new Random();
        _btnText = comments[rdm.nextInt(comments.length)];
        _controller.add(PuzzleEvent.noop);
        _clickCount = 0;


        List list = new List();

        for(int i=0; i < CustomDialogBox.size;i++) {
          List nlist = kkk(i);

        //  nlist.sort();


          LottoNumber bb = new LottoNumber(
              count: i.toString(),
              num1: nlist[0],
              num2: nlist[1],
              num3: nlist[2],
              num4: nlist[3],
              num5: nlist[4],
              num6: nlist[5],
              type: _type
          );


          list.add(bb);

        }


        showDialog(context: LottoNumberList.scaffoldKey.currentContext,
            builder: (BuildContext context){
              return CustomDialogBox(
                title: "이 번호에 느낌이 왔나요?",
                descriptions: "",
                text1: "아뇨,자신없음.",
                text2: "네,왔어요!",
                type: _type,
                list: list,

              );
            }
        );



        timer.cancel();
      }
    }
    );
    //_controller.add(PuzzleEvent.reset);
  }

  bool _clickValue(int value) {
    final newPuzzle = _puzzle.clickValue(value);
    if (newPuzzle == null) {
      return false;
    } else {
      _clickCount++;
      _puzzle = newPuzzle;
      return true;
    }
  }

  void _shake(int tileValue) {
    Point<double> deltaDouble;
    if (solved) {
      deltaDouble = Point(_rnd.nextDouble() - 0.5, _rnd.nextDouble() - 0.5);
    } else {
      final delta = _puzzle.openPosition() - _puzzle.coordinatesOf(tileValue);
      deltaDouble = Point(delta.x.toDouble(), delta.y.toDouble());
    }
    deltaDouble *= 0.5 / deltaDouble.magnitude;

    _locations[tileValue].kick(deltaDouble);
  }

  void update(Duration timeDelta) {
    assert(!timeDelta.isNegative);
    assert(timeDelta != Duration.zero);

    var animationSeconds = timeDelta.inMilliseconds / 60.0;
    if (animationSeconds == 0) {
      animationSeconds = 0.1;
    }
    assert(animationSeconds > 0);

    _stable = true;
    for (var i = 0; i < _puzzle.length; i++) {
      final target = _target(i);
      final body = _locations[i];

      _stable = !body.animate(animationSeconds,
              force: target - body.location,
              drag: .9,
              maxVelocity: 1.0,
              snapTo: target) &&
          _stable;
    }
  }

  Point<double> _target(int item) {
    final target = _puzzle.coordinatesOf(item);
    return Point(target.x.toDouble(), target.y.toDouble());
  }
}
