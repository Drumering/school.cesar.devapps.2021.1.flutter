import 'package:flutter/material.dart';
import 'package:iBarber/src/atoms/favorites_atom.dart';
import 'package:iBarber/src/models/barber_shop_model.dart';

class BarberShopCard extends StatefulWidget {
  const BarberShopCard({
    super.key,
    required this.barberShop,
  });

  final BarberShop barberShop;

  @override
  State<BarberShopCard> createState() => _BarberShopCardState();
}

class _BarberShopCardState extends State<BarberShopCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: IntrinsicWidth(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/barberDetail',
              arguments: widget.barberShop,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/barbershop.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.barberShop.name),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.barberShop.favorite =
                              !widget.barberShop.favorite!;
                        });
                        if (widget.barberShop.favorite!) {
                          favorites.value.add(widget.barberShop);
                        } else {
                          favorites.value.remove(widget.barberShop);
                        }
                      },
                      icon: widget.barberShop.favorite!
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border_rounded),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
