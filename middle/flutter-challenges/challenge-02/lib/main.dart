import 'package:challenge_ui_plant_app/constants.dart';
import 'package:challenge_ui_plant_app/views/detail/plant_detail_screen.dart';
import 'package:challenge_ui_plant_app/views/grid/plant_grid_screen.dart';
import 'package:challenge_ui_plant_app/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(splashTimer);
  runApp(const PlantApp());
}

Future splashTimer(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 1));
}

class PlantApp extends StatelessWidget {
  const PlantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: AppLocalizations.of(context)?.plantApp ?? 'Plant App',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      ),
      routes: {
        '/all': (context) => const PlantGridScreen(),
        '/favorites': (context) => const PlantGridScreen(),
        '/detail': (context) => const PlantDetailScreen(),
        '/home': (context) => const HomeScreen(),
      },
      initialRoute: '/home',
    );
  }
}
