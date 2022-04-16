import 'package:challenge_ui_plant_app/data/favorite_plants_datasource.dart';
import 'package:challenge_ui_plant_app/data/plants_datasource.dart';
import 'package:challenge_ui_plant_app/interfaces/plants_datasource_interface.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';
import 'package:challenge_ui_plant_app/repository/plants_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'header_with_searchbox.dart';
import 'recomended_plant_list.dart';
import 'title_with_button_row.dart';

class HomeBodyArguments {
  final List<Plant> plants;
  final Function(Plant plant)? onFavorited;

  const HomeBodyArguments({
    required this.plants,
    this.onFavorited,
  });
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late List<Plant> allPlants = [];
  late List<Plant> favoritePlants = [];
  late PlantsDataSource allPlantsRepository;
  late PlantsDataSource favoritePlantsRepository;

  @override
  void initState() {
    super.initState();

    allPlantsRepository = PlantsRepository(AllPlantsDataSource());
    favoritePlantsRepository = PlantsRepository(FavoritePlantsDataSource());

    _loadPlants();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderWithSearchBox(
              screenSize: screenSize, plants: allPlants, result: _onSearch),
          TitleWithButtonRow(
            title: "Favorite Plants",
            buttonText: "More",
            onPressed: () => Navigator.pushNamed(context, '/favorites',
                arguments: HomeBodyArguments(
                    plants: favoritePlants,
                    onFavorited: (plant) => _onFavoritedPlant(plant))),
          ),
          RecomendedPlantList(
            plants: favoritePlants,
            onFavorited: (plant) => _onFavoritedPlant(plant),
          ),
          TitleWithButtonRow(
            title: "All Plants",
            buttonText: "More",
            onPressed: () => Navigator.pushNamed(context, '/all',
                arguments: HomeBodyArguments(plants: allPlants)),
          ),
          RecomendedPlantList(
            plants: allPlants,
            onFavorited: (plant) => _onFavoritedPlant(plant),
          ),
        ],
      ),
    );
  }

  _onSearch(result) {
    if (result.isEmpty) {
      _loadPlants();
    } else {
      setState(() {
        favoritePlants = result
            .where((Plant element) => element.isFavorite)
            .toList() as List<Plant>;
        allPlants = result
            .where((Plant element) => !element.isFavorite)
            .toList() as List<Plant>;
      });
    }
  }

  void _loadPlants() async {
    final allPlants = await allPlantsRepository.getPlants();
    final favoritePlants = await favoritePlantsRepository.getPlants();
    setState(() {
      this.allPlants = allPlants;
      this.favoritePlants = favoritePlants;
    });
  }

  void _onFavoritedPlant(Plant plant) async {
    plant.isFavorite = !plant.isFavorite;
    await favoritePlantsRepository.addPlant(plant).then((_) => {_loadPlants()},
        onError: (e, s) => {
              if (e is DatabaseException)
                {
                  if (e.isUniqueConstraintError())
                    {
                      favoritePlantsRepository
                          .deletePlant(plant.id.toString())
                          .then((_) => {_loadPlants()})
                    }
                }
            });
  }
}
