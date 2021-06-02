import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future database() async {
    final databasePath = await getDatabasesPath();

    return openDatabase(join(databasePath, 'notes_database.db'),
        onCreate: (database, version) {
      return database.execute(
          'id INTEGER PRIMARY KEY, title TEXT, content TEXT, imagePath TEXT, color TEXT, isAchived TEXT');
    },version: 1);
  }
  static Future<List<Map<String,dynamic>>> getNotedFromDb()async{
    final database = await DatabaseHelper.database();
    return database.query("notes",orderBy: "id DESC");
  }
}
