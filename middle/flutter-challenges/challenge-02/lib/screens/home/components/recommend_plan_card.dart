import 'package:challenge_ui_plant_app/constants.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';
import 'package:flutter/material.dart';

class RecomendedPlanCard extends StatelessWidget {
  final Plant plant;
  final Function()? onPressed;
  final Function()? onFavorited;

  const RecomendedPlanCard({
    Key? key,
    required this.plant,
    this.onPressed,
    this.onFavorited,
  }) : super(key: key);

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
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  plant.image,
                  fit: BoxFit.cover,
                  height: screenSize.height * 0.35,
                ),
              ),
              Positioned(
                  bottom: 8,
                  right: 8,
                  child: InkWell(
                    onTap: onFavorited,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          plant.title.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.button,
                        ),
                        Text(plant.country.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: kPrimaryColor.withOpacity(0.5))),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "\$${plant.price}",
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
