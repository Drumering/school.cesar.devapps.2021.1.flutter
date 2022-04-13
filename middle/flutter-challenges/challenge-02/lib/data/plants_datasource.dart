import 'package:challenge_ui_plant_app/interfaces/plants_datasource_interface.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';

class AllPlantsDataSource implements PlantsDataSource {
  static const String PLANTS_API = 'https://study-web-app.herokuapp.com/plants';

  static List<Plant> plants = [
    Plant(
        title: 'Ageratum',
        country: 'United States',
        image:
            'https://extension.umass.edu/plant-identification/sites/plant-identification/files/plant/images/growth/Ageratum%201%20Plant.jpg',
        price: 445),
    Plant(
        title: 'American Marigold',
        country: 'Australia',
        image:
            'https://extension.umass.edu/plant-identification/sites/plant-identification/files/plant/images/growth/Tagetes%201%20plant_0.jpg',
        price: 448),
    Plant(
        title: 'Annual Vinca',
        country: 'China',
        image:
            'https://extension.umass.edu/plant-identification/sites/plant-identification/files/styles/150x150/public/plant/images/growth/Catharanthus%201%20plant.JPG?itok=_Ajs5RLo',
        price: 449),
    Plant(
        title: 'Bacopa',
        country: 'Brasil',
        image:
            'https://extension.umass.edu/plant-identification/sites/plant-identification/files/styles/150x150/public/plant/images/growth/Sutera%20plant%201_0.JPG?itok=5xl1_VDt',
        price: 450),
    Plant(
        title: 'Balloon Flower',
        country: 'Canada',
        image:
            'https://extension.umass.edu/plant-identification/sites/plant-identification/files/plant/images/growth/Platycodon%20plant%202%20%28fall%20color%29_0.jpg',
        price: 451),
  ];

  @override
  Future<void> addPlant(Plant plant) {
    // TODO: implement addPlant
    throw UnimplementedError();
  }

  @override
  Future<void> deletePlant(String id) {
    // TODO: implement deletePlant
    throw UnimplementedError();
  }

  @override
  Future<Plant> getPlant(String id) {
    // TODO: implement getPlant
    throw UnimplementedError();
  }

  @override
  Future<List<Plant>> getPlants() async {
    return plants;
  }

  @override
  Future<int> updatePlant(Plant plant) {
    // TODO: implement updatePlant
    throw UnimplementedError();
  }
}
