import 'package:challenge_ui_plant_app/models/plant.dart';

abstract class PlantsDataSource {
  Future<List<Plant>> getPlants();
  Future<Plant> getPlant(String id);
  Future<void> addPlant(Plant plant);
  Future<int> updatePlant(Plant plant);
  Future<void> deletePlant(String id);
}
