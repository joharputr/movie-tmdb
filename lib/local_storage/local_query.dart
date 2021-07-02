import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DbHelper {
  static const String TABLE_NAME = "moviedb";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , image TEXT date TEXT rating TEXT) ";
  static const String SELECT = "select * from $TABLE_NAME";

  //membuat method singleton
  static DbHelper _dbHelper = DbHelper._singleton();

  factory DbHelper() {
    return _dbHelper;
  }

  DbHelper._singleton();

  //baris terakhir singleton

  Future<Database> openDB() async {
    final dbPath = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(path.join(dbPath, 'thengoding.db'),
        onCreate: (db, version) async {
      await db.execute(CREATE_TABLE).then((value) {
        print("berashil ");
      }).catchError((err) {
        print("errornya ${err.toString()}");
      });
      print('TableCreated');
    }, version: 1);
  }

  insert(String table, Map<String, Object> data) {
    openDB().then((db) {
      db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
    }).catchError((err) {
      print("error $err");
    });
  }

  Future<List> getData(String tableName) async {
    final db = await openDB();
    var result = await db.query(tableName);
    return result.toList();
  }
}
