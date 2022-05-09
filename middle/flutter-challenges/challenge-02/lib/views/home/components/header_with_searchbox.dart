import 'package:challenge_ui_plant_app/constants.dart';
import 'package:challenge_ui_plant_app/controllers/plants_controller.dart';
import 'package:challenge_ui_plant_app/models/plant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key? key,
    required this.screenSize,
    required this.plants,
    this.result,
  }) : super(key: key);

  final Size screenSize;
  final List<Plant> plants;
  final Function(List<Plant> filtered)? result;

  @override
  Widget build(BuildContext context) {
    final PlantsController plantsController = PlantsController();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding),
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.plantApp,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(kDefaultPadding) / 2,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                )
              ]),
          child: TextField(
            onChanged: (value) {
              if (value.isEmpty) {
                result?.call([]);
              } else {
                final filtered =
                    plantsController.getPlantsBySearch(value, plants);
                result?.call(filtered);
              }
            },
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)?.search,
                hintStyle: TextStyle(
                  color: kPrimaryColor.withOpacity(0.5),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                suffixIcon: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: SvgPicture.asset("assets/icons/search.svg"),
                )),
          ),
        ),
      ],
    );
  }
}
