import 'package:challenge_ui_plant_app/data/database.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class PlantsDataSource {
  Future<List<Plant>> getPlants();
  Future<Plant> getPlant(String id);
  Future<void> addPlant(Plant plant);
  Future<Plant> updatePlant(Plant plant);
  Future<void> deletePlant(String id);
}

class PlantsRepository implements PlantsDataSource {
  late Database db;

  PlantsRepository._();
  static final datasource = PlantsRepository._();

  @override
  Future<int> addPlant(Plant plant) async {
    db = await DB.instance.database;
    return db.insert(DB.plantTable, plant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.rollback);
  }

  @override
  Future<int> deletePlant(String id) async {
    db = await DB.instance.database;
    return db.delete(DB.plantTable, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<Plant> getPlant(String id) {
    // TODO: implement getPlant
    throw UnimplementedError();
  }

  @override
  Future<List<Plant>> getPlants() async {
    db = await DB.instance.database;
    List<Map<String, dynamic>> plants = await db.query(DB.plantTable);
    return List.generate(plants.length, (index) {
      return Plant(
        id: plants[index]['id'],
        title: plants[index]['title'],
        country: plants[index]['country'],
        image: plants[index]['image'],
        price: plants[index]['price'],
      );
    });
  }

  @override
  Future<Plant> updatePlant(Plant plant) {
    // TODO: implement updatePlant
    throw UnimplementedError();
  }
}
