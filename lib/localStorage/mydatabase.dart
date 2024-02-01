// ignore_for_file: avoid_print
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalDatabase {
  static Database? myDB;
  static const version = 1;

  static Future<Database?> myDBcheck() async {
    if (myDB == null) {
      myDB = await initializeDB();
      return myDB;
    } else {
      return myDB;
    }
  }

  static Future<Database> initializeDB() async {
    String databaseDestination = await getDatabasesPath();
    String databasePath = join(databaseDestination, 'carpool1.db');
    Database carPoolDB = await openDatabase(
      databasePath,
      version: version,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE IF NOT EXISTS 'CARPOOL'(
          'ID' TEXT NOT NULL PRIMARY KEY,
          'NAME' TEXT NOT NULL,
          'EMAIL' TEXT NOT NULL,
          'PHONE' TEXT NOT NULL,
          'PASSWORD' TEXT NOT NULL,
          'BALANCE' INTEGER NOT NULL
          )
        ''');
        print('Database created!');
      },
    );
    return carPoolDB;
  }

  static Future<List<Map<String, dynamic>>> reading(String sql) async {
    Database? data = await myDBcheck();
    var response = await data!.rawQuery(sql);
    return response;
  }

  static Future<int> writing(sql) async {
    Database? data = await myDBcheck();
    var response = data!.rawInsert(sql);
    return response;
  }

  static Future<int> deleting(sql) async {
    Database? data = await myDBcheck();
    var response = data!.rawDelete(sql);
    return response;
  }

  static Future<int> updating(sql) async {
    Database? data = await myDBcheck();
    var response = data!.rawUpdate(sql);
    return response;
  }

  static Future<void> checking() async {
    String databaseDestination = await getDatabasesPath();
    String databasePath = join(databaseDestination, 'carpool1.db');
    await databaseExists(databasePath) ? print("exists") : print("no db");
  }

  static Future<void> reseting() async {
    String databaseDestination = await getDatabasesPath();
    String databasePath = join(databaseDestination, 'carpool1.db');
    await deleteDatabase(databasePath);
  }
}
