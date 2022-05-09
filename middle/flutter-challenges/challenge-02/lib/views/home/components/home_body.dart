import 'package:challenge_ui_plant_app/controllers/plants_controller.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  late PlantsController plantsController;

  @override
  void initState() {
    super.initState();

    plantsController = PlantsController();

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
            title: AppLocalizations.of(context)!.favoritePlants,
            buttonText: AppLocalizations.of(context)!.more,
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
            title: AppLocalizations.of(context)!.allPlants,
            buttonText: AppLocalizations.of(context)!.more,
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

  _onSearch(List<Plant> result) {
    if (result.isEmpty) {
      _loadPlants();
    } else {
      setState(() {
        favoritePlants = plantsController.getPlantsByCategory(result);
        allPlants =
            plantsController.getPlantsByCategory(result, isFavorite: false);
      });
    }
  }

  void _loadPlants() async {
    final allPlants = await plantsController.getAllPlants();
    final favoritePlants = await plantsController.getFavoritePlants();
    setState(() {
      this.allPlants = allPlants;
      this.favoritePlants = favoritePlants;
    });
  }

  void _onFavoritedPlant(Plant plant) async {
    plant.isFavorite = !plant.isFavorite;
    await plantsController.addFavoritePlant(plant, () => _loadPlants());
  }
}
