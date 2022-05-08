import 'package:challenge_ui_plant_app/constants.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';
import 'package:flutter/material.dart';

import 'recommend_plant_card.dart';

class RecommendedPLantListArguments {
  RecommendedPLantListArguments({required this.plant});

  final Plant plant;
}

class RecomendedPlantList extends StatelessWidget {
  const RecomendedPlantList({
    Key? key,
    required this.plants,
    this.onFavorited,
  }) : super(key: key);

  final List<Plant> plants;
  final Function(Plant plant)? onFavorited;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(
          right: kDefaultPadding,
        ),
        child: Row(
          children: List.generate(
              plants.length,
              (index) => RecomendedPlantCard(
                    plant: plants[index],
                    onPressed: () => Navigator.pushNamed(context, '/detail',
                        arguments: RecommendedPLantListArguments(
                            plant: plants[index])),
                    onFavorited: (plant) => onFavorited?.call(plant),
                  )),
        ),
      ),
    );
  }
}
