import 'package:flutter/material.dart';
import 'package:lotto365/home/HomePage.dart';

void main() {

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





