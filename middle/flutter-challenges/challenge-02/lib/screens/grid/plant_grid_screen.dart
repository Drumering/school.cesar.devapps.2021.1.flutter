import 'package:challenge_ui_plant_app/constants.dart';
import 'package:challenge_ui_plant_app/screens/home/components/home_body.dart';
import 'package:challenge_ui_plant_app/screens/home/components/recomended_plant_list.dart';
import 'package:challenge_ui_plant_app/screens/home/components/recommend_plant_card.dart';
import 'package:flutter/material.dart';

class PlantGridScreen extends StatelessWidget {
  const PlantGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as HomeBodyArguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            args.plants.length,
            (index) => RecomendedPlantCard(
              plant: args.plants[index],
              onPressed: () => Navigator.pushNamed(context, '/detail',
                  arguments:
                      RecommendedPLantListArguments(plant: args.plants[index])),
              onFavorited: (plant) => args.onFavorited?.call(plant),
            ),
          )),
    );
  }
}
