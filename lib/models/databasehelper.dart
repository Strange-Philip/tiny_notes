import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future database() async {
    final databasePath = await getDatabasesPath();

    return openDatabase(join(databasePath, 'notes_database.db'),
        onCreate: (database, version) {
      return database.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT, imagePath TEXT, color TEXT, isAchived BIT)');
    }, version: 1);
  }

  static Future insert(Map<String, Object> data) async {
    final database = await DatabaseHelper.database();
    database.insert("notes", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getNotedFromDb() async {
    final database = await DatabaseHelper.database();
    return database.query("notes", orderBy: "id DESC");
  }

  static Future delete(int id) async {
    final database = await DatabaseHelper.database();
    return database.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
