import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static const String plantDatabase = 'plant_app.db';
  static const String plantTable = 'plant';

  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), plantDatabase),
        version: 1, onCreate: _onCreate);
  }

  _onCreate(db, version) async {
    await db.execute(
      'CREATE TABLE $plantTable(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, country TEXT, image TEXT, price INTEGER)',
    );
  }
}
