import 'package:flutter/material.dart';

import 'recommend_plan_card.dart';

class RecomemdedPlantList extends StatelessWidget {
  const RecomemdedPlantList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const RecomendedPlanCard(
            image: "assets/images/image_1.png",
            title: "Samatha",
            country: "Russia",
            price: 445,
          ),
          const RecomendedPlanCard(
            image: "assets/images/image_1.png",
            title: "Samatha",
            country: "Russia",
            price: 445,
          ),
          const RecomendedPlanCard(
            image: "assets/images/image_1.png",
            title: "Samatha",
            country: "Russia",
            price: 445,
          ),
        ],
      ),
    );
  }
}
