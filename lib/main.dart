import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:bingolotto45/home/HomePage.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  reqTrackAds();
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
     // '/detail/1': (context) => PlanetDetailPage(),

    },
    title: "Planets",
    home: new HomePage(),
  ));
}

void reqTrackAds() async {
  await Admob.requestTrackingAuthorization();
}




