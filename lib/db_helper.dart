import 'dart:io';

import 'package:bingolotto45/model/LottoNumber.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



final String TableName = 'tb_lotto';

class DBHelper {
  DBHelper._();

  static final DBHelper _db = DBHelper._();

  factory DBHelper() => _db;

  static Database _database;

  Future<Database> get database async {
    print('getDataBase');
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }


  initDB() async {
    print('initDB');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'DoodleDB.db');

    return await openDatabase(path, version: 5, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $TableName(
            dt TEXT PRIMARY KEY,  
            num1 INTEGER , 
            num2 INTEGER,
            num3 INTEGER,
            num4 INTEGER,
            num5 INTEGER,
            num6 INTEGER, 
            type INTEGER,
            cnt TEXT
          )
        ''');
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < newVersion
      ) {
        print('sql list $oldVersion $newVersion');
      }
    });
  }


  addNumber(LottoNumber bb) async {
    print('${bb.type} ${bb.num1}');

    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO $TableName(dt,num1,num2,num3,num4,num5,num6,type,cnt) VALUES(date( 'now','localtime')||time( 'now','localtime')||?,?,?,?,?,?,?,?,?)",
        [bb.count,bb.num1, bb.num2, bb.num3, bb.num4, bb.num5, bb.num6, bb.type,bb.count]);

    print(res);

    return res;
  }


  //Delete
  Future<int> removeNumber(String dt) async {
    final db = await database;
    var res = db.rawDelete('DELETE FROM $TableName WHERE dt = ?', [dt]);
    return res;
  }

  //Delete
  clearNumbers() async {
    final db = await database;
    var res = db.rawDelete('DELETE FROM $TableName  ');
    return res;
  }

  Future<LottoNumber> getNumber(String dt) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT   dt,   num1 ,   num2,   num3 ,   num4,   num5 ,   num6 , type,cnt   FROM $TableName b  where dt = ?',
        [dt]);
    return res.isNotEmpty
        ? LottoNumber(
        dt: res.first['dt'],
        num1: res.first['num1'],
        num2: res.first['num2'],
        num3: res.first['num3'],
        num4: res.first['num4'],
        num5: res.first['num5'],
        num6: res.first['num6'],
        count: res.first['cnt'],
        type: res.first['type']

    )
        : Null;
  }

  //Baby All
  Future<List<LottoNumber>> getNumbers() async {
    print('getNumbers');

    final db = await database;
    var res = await db.rawQuery(
        'SELECT   dt,   num1 ,   num2,   num3 ,   num4,   num5 ,   num6 , type ,cnt  FROM $TableName order by dt desc   ');
    List<LottoNumber> list = res.isNotEmpty
        ? res
        .map((c) =>
        LottoNumber(
            dt: c['dt'],
            num1: c['num1'],
            num2: c['num2'],
            num3: c['num3'],
            num4: c['num4'],
            num5: c['num5'],
            num6: c['num6'],
            count: c['cnt'],
            type: c['type']
        ))
        .toList()
        : [];

    return list;
  }
}