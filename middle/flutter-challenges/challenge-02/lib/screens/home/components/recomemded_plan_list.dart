import 'package:challenge_ui_plant_app/constants.dart';
import 'package:challenge_ui_plant_app/data/favorite_plants_datasource.dart';
import 'package:challenge_ui_plant_app/data/plants_datasource.dart';
import 'package:challenge_ui_plant_app/interfaces/plants_datasource_interface.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';
import 'package:challenge_ui_plant_app/repository/plants_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import 'recommend_plan_card.dart';

class RecomendedPlantList extends StatefulWidget {
  const RecomendedPlantList({
    Key? key,
    this.isFavoriteList = false,
  }) : super(key: key);

  final bool isFavoriteList;

  @override
  State<RecomendedPlantList> createState() => _RecomendedPlantListState();
}

class _RecomendedPlantListState extends State<RecomendedPlantList> {
  List<Plant>? plants;
  late PlantsDataSource repository;

  @override
  void initState() {
    super.initState();
    repository = PlantsRepository(widget.isFavoriteList
        ? FavoritePlantsDataSource()
        : AllPlantsDataSource());
    _loadPlants();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(
          right: kDefaultPadding,
        ),
        child: Row(
          children: (plants != null)
              ? List.generate(
                  plants!.length,
                  (index) => RecomendedPlanCard(
                        plant: plants![index],
                        onPressed: () =>
                            Navigator.pushNamed(context, '/detail'),
                        onFavorited: () async {
                          await repository
                              .addPlant(Plant(
                                  id: 1,
                                  title: plants![index].title,
                                  country: plants![index].country,
                                  image: plants![index].image,
                                  price: plants![index].price))
                              .catchError((e, s) {
                            if (e is DatabaseException) {
                              if (e.isUniqueConstraintError()) {
                                return repository
                                    .deletePlant(plants![index].id.toString());
                              }
                            }
                          });
                        },
                      ))
              : [],
        ),
      ),
    );
  }

  void _loadPlants() async {
    final plants = await repository.getPlants();
    setState(() {
      this.plants = plants;
    });
  }
}
