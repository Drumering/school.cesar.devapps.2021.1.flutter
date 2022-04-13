import 'package:challenge_ui_plant_app/interfaces/plants_datasource_interface.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoritePlantsDataSource implements PlantsDataSource {
  static const String plantDatabase = 'plant_app.db';
  static const String plantTable = 'plant';

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), plantDatabase),
        version: 1, onCreate: _onCreate);
  }

  _onCreate(db, version) async {
    await db.execute(
      'CREATE TABLE $plantTable(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, country TEXT, image TEXT, price INTEGER, isFavorite INTEGER)',
    );
  }

  @override
  Future<int> addPlant(Plant plant) async {
    final db = await database;
    return db!.insert(plantTable, plant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.rollback);
  }

  @override
  Future<int> deletePlant(String id) async {
    final db = await database;
    return db!.delete(plantTable, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<Plant> getPlant(String id) async {
    Plant plant;
    final db = await database;
    plant = db!.query(plantTable, where: 'id = ?', whereArgs: [id]) as Plant;
    return plant;
  }

  @override
  Future<List<Plant>> getPlants() async {
    final db = await database;
    List<Map<String, dynamic>> plants = await db!.query(plantTable);
    return List.generate(plants.length, (index) {
      return Plant(
        id: plants[index]['id'],
        title: plants[index]['title'],
        country: plants[index]['country'],
        image: plants[index]['image'],
        price: plants[index]['price'],
        isFavorite: plants[index]['isFavorite'] == 0 ? false : true,
      );
    });
  }

  @override
  Future<int> updatePlant(Plant plant) async {
    final db = await database;
    return db!.update(plantTable, plant.toMap(),
        where: 'id = ?', whereArgs: [plant.id]);
  }
}
