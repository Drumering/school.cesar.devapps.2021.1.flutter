import 'package:flutter/material.dart';
import 'package:iBarber/src/components/barber_shop_card_component.dart';
import 'package:iBarber/src/models/barber_shop_model.dart';

class BarberShopGridView extends StatelessWidget {
  const BarberShopGridView({
    super.key,
    required this.barberShopList,
  });

  final List<BarberShop> barberShopList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          barberShopList.length,
          (index) => BarberShopCard(
            barberShop: barberShopList[index],
          ),
        ),
      ),
    );
  }
}
