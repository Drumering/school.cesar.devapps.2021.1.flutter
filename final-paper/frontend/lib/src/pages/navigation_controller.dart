import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iBarber/src/pages/favorites_page.dart';
import 'package:iBarber/src/pages/home_page.dart';
import 'package:iBarber/src/pages/settings_page.dart';

class NavigationController extends StatefulWidget {
  const NavigationController({super.key});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget switchPages(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const FavoritesPage();
      default:
        return const SettingsPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
        gap: 8,
        tabs: const [
          GButton(
            icon: Icons.home_rounded,
            text: 'Home',
          ),
          GButton(
            icon: Icons.favorite_outline,
            text: 'Favoritos',
          ),
          GButton(
            icon: Icons.settings,
            text: 'Configurações',
          ),
        ],
      ),
      body: switchPages(_selectedIndex),
    );
  }
}
