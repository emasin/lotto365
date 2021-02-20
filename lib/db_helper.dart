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
            
            id INTEGER PRIMARY KEY,
            name TEXT,
            tm TEXT,
            dt TEXT,
            content TEXT,
            doodle TEXT,
            iconBackground INTEGER,
            icon INTEGER , 
            mtype INTEGER,
            stype INTEGER,
            val INTEGER,
            strVal1 TEXT,
            strVal2 TEXT,
            bid INTEGER,
            auid TEXT
            
            
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
    print('addBaby');

    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO $TableName(dt,num1,num2,num3,num4,num5,num6,type) VALUES(CONCAT(date( 'now','localtime'),time( 'now','localtime')),?,?,?,?,?,?,?)",
        [bb.num1, bb.num2, bb.num3, bb.num4, bb.num5, bb.num6, bb.type]);


    return res;
  }


  //Delete
  Future<int> removeNumber(String dt) async {
    final db = await database;
    var res = db.rawDelete('DELETE FROM $TableName WHERE dt = ?', [dt]);
    return res;
  }

  //Delete
  clearBabies() async {
    final db = await database;
    var res = db.rawDelete('DELETE FROM $TableName  ');
    return res;
  }

  Future<LottoNumber> getNumber(String dt) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT   dt,   num1 ,   num2,   num3 ,   num4,   num5 ,   num6 , type   FROM $TableName b  where dt = ?',
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

        type: res.first['type']

    )
        : Null;
  }

  //Baby All
  Future<List<LottoNumber>> getNumbers() async {
    print('getNumbers');

    final db = await database;
    var res = await db.rawQuery(
        'SELECT   dt,   num1 ,   num2,   num3 ,   num4,   num5 ,   num6 , type   FROM $TableName  ');
    List<LottoNumber> list = res.isNotEmpty
        ? res
        .map((c) =>
        LottoNumber(
            dt: res.first['dt'],
            num1: res.first['num1'],
            num2: res.first['num2'],
            num3: res.first['num3'],
            num4: res.first['num4'],
            num5: res.first['num5'],
            num6: res.first['num6'],

            type: res.first['type']
        ))
        .toList()
        : [];

    return list;
  }
}