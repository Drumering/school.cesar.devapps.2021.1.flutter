import 'package:challenge_ui_plant_app/data/favorite_plants_datasource.dart';
import 'package:challenge_ui_plant_app/data/plants_datasource.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';
import 'package:challenge_ui_plant_app/repository/plants_repository.dart';
import 'package:sqflite/sqflite.dart';

class PlantsController {
  final allPlantsRepository = PlantsRepository(AllPlantsDataSource());
  final favoritePlantsRepository = PlantsRepository(FavoritePlantsDataSource());

  // Method to get all plants
  Future<List<Plant>> getAllPlants() async {
    return await allPlantsRepository.getPlants();
  }

  // Method to get a plant by id
  Future<Plant> getPlant(String id) async {
    return await allPlantsRepository.getPlant(id);
  }

  // Method to add a plant
  Future<void> addPlant(Plant plant) async {
    return await allPlantsRepository.addPlant(plant);
  }

  // Method to update a plant
  Future<int> updatePlant(Plant plant) async {
    return await allPlantsRepository.updatePlant(plant);
  }

  // Method to delete a plant
  Future<void> deletePlant(String id) async {
    return await allPlantsRepository.deletePlant(id);
  }

  // Method to get favorite plants
  Future<List<Plant>> getFavoritePlants() async {
    return await favoritePlantsRepository.getPlants();
  }

  // Method to add a plant to favorite plants
  Future<void> addFavoritePlant(Plant plant, Function()? reloadPlants) async {
    return await favoritePlantsRepository
        .addPlant(plant)
        .then((_) => reloadPlants?.call(),
            onError: (e, s) => {
                  if (e is DatabaseException)
                    {
                      if (e.isUniqueConstraintError())
                        {
                          favoritePlantsRepository
                              .deletePlant(plant.id.toString())
                              .then((_) => {reloadPlants?.call()})
                        }
                    }
                });
  }

  // Method to delete a plant from favorite plants
  Future<void> deleteFavoritePlant(String id) async {
    return await favoritePlantsRepository.deletePlant(id);
  }

  // Method to get plants by search
  List<Plant> getPlantsBySearch(String search, List<Plant> plants) {
    return plants
        .where(
            (plant) => plant.title.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  // Method to get plants by category
  List<Plant> getPlantsByCategory(List<Plant> plants,
      {bool isFavorite = true}) {
    return plants.where((plant) => isFavorite).toList();
  }
}
