import 'package:flutter/material.dart';
import 'package:bingolotto45/home/PlanetRow.dart';
import 'package:bingolotto45/Theme.dart' as Theme;
import 'package:bingolotto45/model/Planets.dart';

class PlanetList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new Container(
        color: Theme.Colors.planetPageBackground,
        child: new ListView.builder(
          itemExtent: 80.0,
          itemCount: PlanetDao.planets.length,
          itemBuilder: (_, index) => new PlanetRow(PlanetDao.planets[index]),
        ),
      ),
    );
  }
}