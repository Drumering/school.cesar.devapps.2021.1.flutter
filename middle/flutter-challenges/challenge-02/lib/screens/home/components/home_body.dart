import 'dart:ffi';

import 'package:challenge_ui_plant_app/constants.dart';
import 'package:challenge_ui_plant_app/screens/home/components/recommend_plan_card.dart';
import 'package:flutter/material.dart';

import 'header_with_searchbox.dart';
import 'recomemded_plan_list.dart';
import 'title_with_button_row.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return 
    SingleChildScrollView( 
      child: Column(
        children: [
          HeaderWithSearchBox(
            screenSize: screenSize
          ),

          TitleWithButtonRow(
            title: "Favorite Plants",
            buttonText: "More",
            onPressed: () {},
          ),

          const RecomemdedPlantList(),

          TitleWithButtonRow(
            title: "All Plants",
            buttonText: "More",
            onPressed: () {},
          ),

          const RecomemdedPlantList(),

        ],
      ),
    );
  }
}
