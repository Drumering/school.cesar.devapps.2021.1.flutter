import 'package:challenge_ui_plant_app/interfaces/plants_datasource_interface.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';

class PlantsRepository implements PlantsDataSource {
  final PlantsDataSource dataSource;
  PlantsRepository(this.dataSource);

  @override
  Future<void> addPlant(Plant plant) async {
    return await dataSource.addPlant(plant);
  }

  @override
  Future<void> deletePlant(String id) async {
    return await dataSource.deletePlant(id);
  }

  @override
  Future<Plant> getPlant(String id) async {
    return await dataSource.getPlant(id);
  }

  @override
  Future<List<Plant>> getPlants() async {
    return await dataSource.getPlants();
  }

  @override
  Future<int> updatePlant(Plant plant) async {
    return await dataSource.updatePlant(plant);
  }
}
