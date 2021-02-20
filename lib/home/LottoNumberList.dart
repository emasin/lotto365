import 'package:bingolotto45/db_helper.dart';
import 'package:bingolotto45/model/LottoNumber.dart';
import 'package:flutter/material.dart';
import 'package:bingolotto45/home/PlanetRow.dart';
import 'package:bingolotto45/Theme.dart' as Theme;
import 'package:bingolotto45/model/Planets.dart';

class LottoNumberList extends StatefulWidget {
  static GlobalKey<_LottoNumberListState> scaffoldKey = new GlobalKey<_LottoNumberListState>();
  LottoNumberList() : super(key: LottoNumberList.scaffoldKey);
  @override
  _LottoNumberListState createState() => new _LottoNumberListState();
}

class _LottoNumberListState extends State<LottoNumberList> {
  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new Container(


        color: Theme.Colors.planetPageBackground,
        child: FutureBuilder<List<LottoNumber>>(
          future: DBHelper().getNumbers(),
          builder: (context, snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: Text("데이터가 없습니다."),
              );
            } else {
              if(snapshot.data.length == 0)
                return Row(children: <Widget>[Text("내가 태어날 확률은 1/800,000,000,000. 로또 확률은? 풋 ")],mainAxisAlignment: MainAxisAlignment.center,);

              print("has data ??? dashboard");
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  {
                    return ListView.builder(

                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        LottoNumber db = snapshot.data[index];
                        print("${db.dt} $index ${db.type}");

                        return Container(
                            height: 70.0,
                            margin: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(child: Container(child: Text(db.num1.toString()),decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("asset/ball1.png"),
                              ),
                            ),alignment: Alignment.center,),),
                            Expanded(child: Container(child: Text(db.num2.toString()),decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("asset/ball2.png"),
                              ),
                            ),alignment: Alignment.center,),),
                            Expanded(child: Container(child: Text(db.num3.toString()),decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("asset/ball3.png"),
                              ),
                            ),alignment: Alignment.center,),),
                            Expanded(child: Container(child: Text(db.num4.toString()),decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("asset/ball4.png"),
                              ),
                            ),alignment: Alignment.center,),),
                            Expanded(child: Container(child: Text(db.num5.toString()),decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("asset/ball5.png"),
                              ),
                            ),alignment: Alignment.center,),),
                            Expanded(child: Container(child: Text(db.num6.toString()),decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("asset/ball6.png"),
                              ),
                            ),alignment: Alignment.center,),),
                          ],
                        ));
                      },
                    );
                  }

              }

            }

          },

        ),
      ),
    );
  }
}