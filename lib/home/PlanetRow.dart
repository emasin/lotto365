import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:bingolotto45/Theme.dart' as Theme;
import 'package:bingolotto45/model/Planet.dart';


class PlanetRow extends StatelessWidget {

  final Planet planet;

  PlanetRow(this.planet);

  @override
  Widget build(BuildContext context) {
     

    final planetCard = new Container(
      margin: const EdgeInsets.only(left: 72.0, right: 24.0),
      decoration: new BoxDecoration(
        color: Theme.Colors.planetCard,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(color: Colors.black,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0))
        ],
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(planet.name, style: Theme.TextStyles.planetTitle),
            new Text(planet.location, style: Theme.TextStyles.planetLocation),
            new Container(
              color: const Color(0xFF00C6FF),
              width: 24.0,
              height: 1.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0)
            ),
            new Row(
              children: <Widget>[
                new Icon(Icons.location_on, size: 14.0,
                  color: Theme.Colors.planetDistance),
                new Text(
                  planet.distance, style: Theme.TextStyles.planetDistance),
                new Container(width: 24.0),
                new Icon(Icons.flight_land, size: 14.0,
                  color: Theme.Colors.planetDistance),
                new Text(
                  planet.gravity, style: Theme.TextStyles.planetDistance),
              ],
            )
          ],
        ),
      ),
    );

    return new Container(
      height: 100.0,
      margin: const EdgeInsets.only(top: 10.0, bottom: 8.0),
      child: new FlatButton(
        onPressed: () => _navigateTo(context, planet.id),

        child: new Row(
          children: <Widget>[
            Expanded(child: Container(child: Text("6"),decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("asset/ball1.png"),
              ),
            ),alignment: Alignment.center,),),
            Expanded(child: Container(child: Text("6"),decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("asset/ball2.png"),
              ),
            ),alignment: Alignment.center,),),
            Expanded(child: Container(child: Text("6"),decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("asset/ball3.png"),
              ),
            ),alignment: Alignment.center,),),
            Expanded(child: Container(child: Text("6"),decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("asset/ball4.png"),
              ),
            ),alignment: Alignment.center,),),
            Expanded(child: Container(child: Text("6"),decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("asset/ball5.png"),
              ),
            ),alignment: Alignment.center,),),
            Expanded(child: Container(child: Text("6"),decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("asset/ball6.png"),
              ),
            ),alignment: Alignment.center,),)

             
          ],
        ),
      ),
    );
  }

  _navigateTo(context, String id) {

  }
}

