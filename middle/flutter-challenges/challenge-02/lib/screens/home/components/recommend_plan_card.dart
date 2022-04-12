import 'package:challenge_ui_plant_app/constants.dart';
import 'package:challenge_ui_plant_app/data/datasource.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class RecomendedPlanCard extends StatelessWidget {
  final String image;
  final String title;
  final String country;
  final int price;
  final Function()? onPressed;

  const RecomendedPlanCard({
    Key? key,
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    this.onPressed,
  }) : super(key: key);

  PlantsRepository get plantsRepository => PlantsRepository.datasource;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5,
        ),
        width: screenSize.width * 0.4,
        child: Column(
          children: [
            Stack(children: [
              Image.asset(image),
              Positioned(
                  bottom: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () async {
                      await plantsRepository
                          .addPlant(Plant(
                              id: 1,
                              title: title,
                              country: country,
                              image: image,
                              price: price))
                          .catchError((e, s) {
                        if (e is DatabaseException) {
                          if (e.isUniqueConstraintError()) {
                            return plantsRepository.deletePlant('1');
                          }
                        }
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: kPrimaryColor,
                    ),
                  ))
            ]),
            Container(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23))
                  ]),
              child: Row(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "$title\n".toUpperCase(),
                        style: Theme.of(context).textTheme.button),
                    TextSpan(
                        text: country.toUpperCase(),
                        style: TextStyle(color: kPrimaryColor.withOpacity(0.5)))
                  ])),
                  const Spacer(),
                  Text(
                    "\$$price",
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
