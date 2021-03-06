import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:bingolotto45/src/const.dart';
import 'package:bingolotto45/src/flutter.dart';
import 'package:debug_mode/debug_mode.dart';
import 'dart:io' show Platform;
import 'dart:math';



bool isTest() {
  return DebugMode.isInDebugMode;
}

String server() {
  return 'http://www.devkids.co.kr';
}

String getAppId() {
  print('app is ios ${Platform.isIOS} android ${Platform.isAndroid}');
  if (!isTest()) {
    if (Platform.isIOS) {
      return 'ca-app-pub-6989543155020547~4050474773';

    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6989543155020547~2856159638';
      //ca-app-pub-6989543155020547~6308069817
    }
  }
  return 'ca-app-pub-3940256099942544~3347511713';
}

String getBannerAdUnitId() {
  if (!isTest()) {
    if (Platform.isIOS) {
       return 'ca-app-pub-6989543155020547/8426122458';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6989543155020547/5613446229';
      // return 'ca-app-pub-6989543155020547/4820277066';
    }
  }
  return 'ca-app-pub-3940256099942544/6300978111';
}

String getInterstitialAdUnitId() {
  if (!isTest()) {
    if (Platform.isIOS) {
       return 'ca-app-pub-6989543155020547/5805017919';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6989543155020547/9575073660';

    }
  }
  return 'ca-app-pub-3940256099942544/1033173712';
}

String getRewardBasedVideoAdUnitId() {
  if (!isTest()) {
    if (Platform.isIOS) {
      return 'ca-app-pub-6989543155020547/9162208067';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-8302815054196330/3362603004';
    }
  }
  return 'ca-app-pub-3940256099942544/5224354917';
}

double getSafeTop() {
  return Platform.isIOS ? 15 : 0;
}


void handleEvent(AdmobAdEvent event, Map<String, dynamic> args, String adType) {
  switch (event) {
    case AdmobAdEvent.loaded:


      break;
    case AdmobAdEvent.opened:

      break;
    case AdmobAdEvent.closed:

      break;
    case AdmobAdEvent.failedToLoad:

      break;
    case AdmobAdEvent.rewarded:
      break;
    default:
  }
}

String nvl(val, val2) {
  if (val == null) return val2;

  return val;
}


Color getLessColor(no) {
  if(no < 10)
    return new Color(less10);
  else if (no < 20)
    return new Color(less20);
  else if (no < 30)
    return new Color(less30);
  else if (no < 40)
    return new Color(less40);
  else
    return new Color(less50);
}

bool isWinNo(Map<String, dynamic> json_data,int no){
  bool isWin = false;
  if(json_data['no1'] == no )
    return true;
  if(json_data['no2'] == no )
    return true;
  if(json_data['no3'] == no )
    return true;
  if(json_data['no4'] == no )
    return true;
  if(json_data['no5'] == no )
    return true;
  if(json_data['no6'] == no )
    return true;

  return isWin;
}

 List recNo(){
  Set<int> setOfInts = Set();
  while (setOfInts.length < 7) {
    setOfInts.add(Random().nextInt(45) + 1);
  }
  print(setOfInts.toList());
  return setOfInts.toList();
}