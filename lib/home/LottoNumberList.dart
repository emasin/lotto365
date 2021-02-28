import 'package:bingolotto45/db_helper.dart';
import 'package:bingolotto45/function.dart';
import 'package:bingolotto45/model/LottoNumber.dart';
import 'package:flutter/material.dart';
import 'package:bingolotto45/home/PlanetRow.dart';
import 'package:bingolotto45/Theme.dart' as Theme;
import 'package:bingolotto45/model/Planets.dart';
import 'package:shimmer/shimmer.dart';

class LottoNumberList extends StatefulWidget {
  static GlobalKey<_LottoNumberListState> scaffoldKey = new GlobalKey<_LottoNumberListState>();
  Map<String, dynamic> json_data;
  LottoNumberList(this.json_data) : super(key: LottoNumberList.scaffoldKey);
  @override
  _LottoNumberListState createState() => new _LottoNumberListState();


}

class _LottoNumberListState extends State<LottoNumberList> {
  @override
  Widget build(BuildContext context) {
    print('win no ,${widget.json_data}');

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

                        return GestureDetector(
                            onLongPress: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: new Text("확인"),
                                    content: new Text("정말 삭제하겠습니까?"),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      new FlatButton(
                                        child: new Text("확인"),
                                        onPressed: () {
                                          DBHelper().removeNumber(db.dt);

                                          Navigator.of(context).pop();
                                          setState(() {

                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child:Container(

                            height: 70.0,
                            margin: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(child: new Container(
                                  margin: EdgeInsets.only(right: 3),
                                  alignment: Alignment.center,
                                  width: 50.0,
                                  height: 50.0,
                                  padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,// You can use like this way or like the below line
                                    //borderRadius: new BorderRadius.circular(30.0),
                                    color: getLessColor(db.num1),
                                  ),
                                  child:  isWinNo(widget.json_data,db.num1) ?  Shimmer.fromColors(
                                    baseColor: Color(0x00000000),
                                    highlightColor: const Color(0xFFD4F0F0),
                                    child: new Text(db.num1.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),
                                  ) :  new Text(db.num1.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),
                                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                                ),),
                                Expanded(child: new Container(
                                  margin: EdgeInsets.only(right: 3),
                                  alignment: Alignment.center,
                                  width: 50.0,
                                  height: 50.0,
                                  padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,// You can use like this way or like the below line
                                    //borderRadius: new BorderRadius.circular(30.0),
                                    color: getLessColor(db.num2),
                                  ),
                                  child:  isWinNo(widget.json_data,db.num2) ?  Shimmer.fromColors(
                                    baseColor: Color(0x00000000),
                                    highlightColor: const Color(0xFFD4F0F0),
                                    child: new Text(db.num2.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),
                                  ) :  new Text(db.num2.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),
                                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                                ),),
                                Expanded(child: new Container(
                                  margin: EdgeInsets.only(right: 3),
                                  alignment: Alignment.center,
                                  width: 50.0,
                                  height: 50.0,
                                  padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,// You can use like this way or like the below line
                                    //borderRadius: new BorderRadius.circular(30.0),
                                    color: getLessColor(db.num3),
                                  ),
                                  child:  isWinNo(widget.json_data,db.num3) ?  Shimmer.fromColors(
                                    baseColor: Color(0x00000000),
                                    highlightColor: const Color(0xFFD4F0F0),
                                    child: new Text(db.num3.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),
                                  ) :  new Text(db.num3.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),// You can add a Icon instead of text also, like below.
                                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                                ),),
                                Expanded(child: new Container(
                                  margin: EdgeInsets.only(right: 3),
                                  alignment: Alignment.center,
                                  width: 50.0,
                                  height: 50.0,
                                  padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,// You can use like this way or like the below line
                                    //borderRadius: new BorderRadius.circular(30.0),
                                    color: getLessColor(db.num4),
                                  ),
                                  child:  isWinNo(widget.json_data,db.num4) ?  Shimmer.fromColors(
                                    baseColor: Color(0x00000000),
                                    highlightColor: const Color(0xFFD4F0F0),
                                    child: new Text(db.num4.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),
                                  ) :  new Text(db.num4.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),// You can add a Icon instead of text also, like below.
                                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                                ),),
                                Expanded(child: new Container(
                                  margin: EdgeInsets.only(right: 3),
                                  alignment: Alignment.center,
                                  width: 50.0,
                                  height: 50.0,
                                  padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,// You can use like this way or like the below line
                                    //borderRadius: new BorderRadius.circular(30.0),
                                    color: getLessColor(db.num5),
                                  ),
                                  child:  isWinNo(widget.json_data,db.num5) ?  Shimmer.fromColors(
                                    baseColor: Color(0x00000000),
                                    highlightColor: const Color(0xFFD4F0F0),
                                    child: new Text(db.num5.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),
                                  ) :  new Text(db.num5.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),// You can add a Icon instead of text also, like below.
                                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                                ),),
                                Expanded(child: new Container(
                                  margin: EdgeInsets.only(right: 3),
                                  alignment: Alignment.center,
                                  width: 50.0,
                                  height: 50.0,

                                  padding: const EdgeInsets.all(5.0),//I used some padding without fixed width and height
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,// You can use like this way or like the below line
                                    color: getLessColor(db.num6),

                                  ),
                                  child: isWinNo(widget.json_data,db.num6) ?  Shimmer.fromColors(
                                    baseColor: Color(0x00000000),
                                    highlightColor: const Color(0xFFD4F0F0),
                                    child: new Text(db.num6.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),
                                  ) :  new Text(db.num6.toString(), style: new TextStyle(color: Colors.white, fontSize: 24.0)),// You can add a Icon instead of text also, like below.
                                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                                ),),
                              ],
                            )) ) ;
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