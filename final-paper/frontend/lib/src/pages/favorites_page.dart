import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:iBarber/src/atoms/favorites_atom.dart';
import 'package:iBarber/src/components/barber_shop_grid_view_component.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    context.select(() => [favorites]);
    var hasFavorites = favorites.value.isNotEmpty;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: !hasFavorites
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            !hasFavorites
                ? const Center(
                    child: Text(
                        'Favorite alguma barbearia na página inicial para vê-la aqui'),
                  )
                : BarberShopGridView(barberShopList: favorites.value),
          ],
        ),
      ),
    );
  }
}
