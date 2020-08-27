import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper2 {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'delTran.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE delTran(id TEXT PRIMARY KEY , name TEXT , amount DOUBLE, description TEXT, currncy TEXT, oldDate TEXT, newDate TEXT, type TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper2.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper2.database();
    return db.query(table);
  }
}
