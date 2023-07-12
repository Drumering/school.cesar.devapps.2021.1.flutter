import 'package:flutter/material.dart';
import 'package:iBarber/src/atoms/local_storage_atom.dart';
import 'package:iBarber/src/atoms/theme_atom.dart';
import 'package:iBarber/src/shared/themes/color_schemes.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<bool> _selectedThemeMode = [
    selectedTheme.value == ThemeMode.light,
    selectedTheme.value == ThemeMode.dark,
  ];

  final List<Widget> themes = [
    const Icon(
      Icons.sunny,
    ),
    const Icon(
      Icons.nightlight_round,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    saveTheme() async {
      final SharedPreferences sharedPreferences = await preferences.value;
      final isLightTheme = selectedTheme.value == ThemeMode.light;
      sharedPreferences.setString('theme', isLightTheme ? 'light' : 'dark');
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Alterne entre modo escuro e claro'),
                    ),
                    ToggleButtons(
                      onPressed: (index) {
                        setState(() {
                          for (var i = 0; i < _selectedThemeMode.length; i++) {
                            _selectedThemeMode[i] = i == index;
                          }
                          selectedTheme.value =
                              index == 0 ? ThemeMode.light : ThemeMode.dark;
                          saveTheme();
                        });
                      },
                      isSelected: _selectedThemeMode,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedColor: lightColorScheme.primary,
                      children: themes,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
