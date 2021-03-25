// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:bingolotto45/function.dart';
import 'package:bingolotto45/home/LottoNumberList.dart';
import 'package:bingolotto45/src/custom_dialog_box.dart';
import 'package:provider/provider.dart';
import 'package:bingolotto45/src/const.dart';

import 'app_state.dart';
import 'core/puzzle_animator.dart';
import 'core/puzzle_proxy.dart';
import 'flutter.dart';
import 'puzzle_controls.dart';
import 'puzzle_flow_delegate.dart';
import 'shared_theme.dart';
import 'themes.dart';
import 'value_tab_controller.dart';

class _PuzzleControls extends ChangeNotifier implements PuzzleControls {
  final PuzzleHomeState _parent;

  _PuzzleControls(this._parent);

  @override
  bool get autoPlay => _parent._autoPlay;

  void _notify() => notifyListeners();

  @override
  void Function(bool newValue) get setAutoPlayFunction {
    if (_parent.puzzle.solved) {
      return null;
    }
    return _parent._setAutoPlay;
  }

  @override
  int get clickCount => _parent.puzzle.clickCount;

  @override
  int get num1 => _parent.puzzle.num1;

  @override
  int get num2 => _parent.puzzle.num2;

  @override
  int get num3 => _parent.puzzle.num3;

  @override
  int get num4 => _parent.puzzle.num4;

  @override
  int get num5 => _parent.puzzle.num5;

  @override
  int get num6 => _parent.puzzle.num6;

  @override
  int get type => _parent.puzzle.type;


  @override
  int get incorrectTiles => _parent.puzzle.incorrectTiles;

  @override
  String get btnText => _parent.puzzle.btnText;

  @override
  void reset() => _parent.puzzle.reset();

}

class PuzzleHomeState extends State
    with SingleTickerProviderStateMixin, AppState {
  @override
  final PuzzleAnimator puzzle;

  @override
  final _AnimationNotifier animationNotifier = _AnimationNotifier();

  Duration _tickerTimeSinceLastEvent = Duration.zero;
  Ticker _ticker;
  Duration _lastElapsed;
  StreamSubscription _puzzleEventSubscription;
  int _type = 0;

  bool _autoPlay = false;
  _PuzzleControls _autoPlayListenable;

  PuzzleHomeState(this.puzzle,this._type) {

    if(_type == 1) {
      themes = themes1;
    } else if(_type == 2) {
      themes = themes2;
    } else if(_type == 3) {
      themes = themes3;
    } else if(_type == 4) {
      themes = themes4;
    } else {
      themes = themes0;
    }
    _puzzleEventSubscription = puzzle.onEvent.listen(_onPuzzleEvent);
  }


  static AdmobInterstitial interstitialAd;
  AdmobBannerSize bannerSize;


  @override
  void initState() {
    super.initState();
    CustomDialogBox.size = 1;
    _autoPlayListenable = _PuzzleControls(this);
    _ticker ??= createTicker(_onTick);
    _autoPlayListenable.reset();

    if(interstitialAd == null) {
      interstitialAd = AdmobInterstitial(
        adUnitId: getInterstitialAdUnitId(),
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.closed) interstitialAd.load();
          handleEvent(event, args, 'Interstitial');
        },
      );

      interstitialAd.load();
    }
    bannerSize = AdmobBannerSize.FULL_BANNER;

   // _ensureTicking();
  }

  void _setAutoPlay(bool newValue) {
    if (newValue != _autoPlay) {
      setState(() {
        // Only allow enabling autoPlay if the puzzle is not solved
        _autoPlayListenable._notify();
        print("newValue $newValue");
        _autoPlay = newValue ;
        if (_autoPlay) {
         //  _ensureTicking();
          CustomDialogBox.size = 5;
        } else {
          CustomDialogBox.size = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<AppState>.value(value: this),
          ListenableProvider<PuzzleControls>.value(
            value: _autoPlayListenable,
          )
        ],
        child: Material(
          child: Stack(
            children: <Widget>[
              const SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image(
                    image: AssetImage('asset/bg.jpg'),
                  ),
                ),
              ),
              const LayoutBuilder(builder: _doBuild),
              SafeArea(child: BackButton(color: Colors.black,onPressed: ()  async {


                LottoNumberList.scaffoldKey.currentState.setState(() {

                });


                Navigator.of(context).pop();

              },)),
              Positioned(child: AdmobBanner(
                adUnitId: getBannerAdUnitId(),
                adSize: AdmobBannerSize.SMART_BANNER(context),
                listener: (AdmobAdEvent event,
                    Map<String, dynamic> args) {
                  handleEvent(event, args, 'Banner');
                },
                onBannerCreated:
                    (AdmobBannerController controller) {
                  // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                  // Normally you don't need to worry about disposing this yourself, it's handled.
                  // If you need direct access to dispose, this is your guy!
                  // controller.dispose();
                },
              ),bottom: 10.0,),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    animationNotifier.dispose();
    _ticker?.dispose();
    _autoPlayListenable?.dispose();
    _puzzleEventSubscription.cancel();
    interstitialAd.dispose();

    super.dispose();
  }

  void _onPuzzleEvent(PuzzleEvent e) {


    _autoPlayListenable._notify();
    if (e != PuzzleEvent.random) {
      //_setAutoPlay(false);
    }
    _tickerTimeSinceLastEvent = Duration.zero;
    _ensureTicking();
    setState(() {
      // noop
    });
  }

  void _ensureTicking() {
    if (!_ticker.isTicking) {
      _ticker.start();
    }
  }

  void _onTick(Duration elapsed) {
    if (elapsed == Duration.zero) {
      _lastElapsed = elapsed;
    }
    final delta = elapsed - _lastElapsed;
    _lastElapsed = elapsed;

    if (delta.inMilliseconds <= 0) {
      // `_delta` may be negative or zero if `elapsed` is zero (first tick)
      // or during a restart. Just ignore this case.
      return;
    }

    _tickerTimeSinceLastEvent += delta;
    puzzle.update(delta > _maxFrameDuration ? _maxFrameDuration : delta);

    if (!puzzle.stable) {
      animationNotifier.animate();
    } else {
      if (!_autoPlay) {
        _ticker.stop();
        _lastElapsed = null;
      }
    }

    if (_autoPlay &&
        _tickerTimeSinceLastEvent > const Duration(milliseconds: 200)) {
      //puzzle.playRandom();

      if (puzzle.solved) {
        _setAutoPlay(false);
      }
    }
  }
}

class _AnimationNotifier extends ChangeNotifier {
  void animate() {
    notifyListeners();
  }
}

const _maxFrameDuration = Duration(milliseconds: 34);

Widget _updateConstraints(
    BoxConstraints constraints, Widget Function(bool small) builder) {
  const _smallWidth = 580;

  final constraintWidth =
      constraints.hasBoundedWidth ? constraints.maxWidth : 1000.0;

  final constraintHeight =
      constraints.hasBoundedHeight ? constraints.maxHeight : 1000.0;

  return builder(constraintWidth < _smallWidth || constraintHeight < 690);
}

Widget _doBuild(BuildContext _, BoxConstraints constraints) =>
    _updateConstraints(constraints, _doBuildCore);

Widget _doBuildCore(bool small) => ValueTabController<SharedTheme>(
      values:  themes,
      child: Consumer<SharedTheme>(
        builder: (_, theme, __) => AnimatedContainer(
          duration: puzzleAnimationDuration,
          color: theme.puzzleThemeBackground,
          child: Center(
            child: theme.styledWrapper(
              small,
              SizedBox(
                width: 580,
                child: Consumer<AppState>(
                  builder: (context, appState, _) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black26,
                              width: 1,
                            ),
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TabBar(
                          controller: ValueTabController.of(context),
                          labelPadding: const EdgeInsets.fromLTRB(0, 20, 0, 12),
                          labelColor: theme.puzzleAccentColor,
                          indicatorColor: theme.puzzleAccentColor,
                          indicatorWeight: 1.5,
                          unselectedLabelColor: Colors.black.withOpacity(0.6),
                          tabs: themes
                              .map((st) => Text(

                                    st.name.toUpperCase(),
                                    style: const TextStyle(
                                      letterSpacing: 0.5,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Flow(
                            delegate: PuzzleFlowDelegate(
                              small ? const Size(smallSize, smallSize) : const Size(largeSize, largeSize),
                              appState.puzzle,
                              appState.animationNotifier,
                            ),
                            children: List<Widget>.generate(
                              appState.puzzle.length,
                              (i) => theme.tileButtonCore(
                                  i, appState.puzzle, small),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black26, width: 1),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          left: 10,
                          bottom: 6,
                          top: 2,
                          right: 10,
                        ),
                        child: Consumer<PuzzleControls>(
                          builder: (_, controls, __) =>
                              Row(children: theme.bottomControls(controls)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
