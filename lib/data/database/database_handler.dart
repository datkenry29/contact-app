import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'contact.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE contact(id INTEGER PRIMARY KEY AUTOINCREMENT, image_url TEXT NOT NULL, first_name TEXT NOT NULL, last_name TEXT NOT NULL, phone TEXT NOT NULL, type_phone TEXT NOT NULL, email TEXT NOT NULL, type_email TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }
}