import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:asp/asp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iBarber/firebase_options.dart';
import 'package:iBarber/src/atoms/local_storage_atom.dart';
import 'package:iBarber/src/atoms/theme_atom.dart';
import 'package:iBarber/src/pages/barber_shop_detail_page.dart';
import 'package:iBarber/src/pages/favorites_page.dart';
import 'package:iBarber/src/pages/navigation_controller.dart';
import 'package:iBarber/src/shared/themes/color_schemes.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RxRoot(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getTheme() async {
    final SharedPreferences prefs = await preferences.value;
    selectedTheme.value =
        prefs.getString('theme') == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  @override
  Widget build(BuildContext context) {
    context.select(() => [selectedTheme]);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: selectedTheme.value,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => AnimatedSplashScreen(
              duration: 3000,
              splashTransition: SplashTransition.fadeTransition,
              splash: Column(
                children: [
                  Expanded(
                    child: Image.asset('assets/mustache.png'),
                  ),
                  const Center(
                    child: Text(
                      'iBarber',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              nextScreen: const NavigationController(),
            ),
        '/favorites': (context) => const FavoritesPage(),
        '/barberDetail': (context) => const BarberShopDetailPage()
      },
    );
  }
}
