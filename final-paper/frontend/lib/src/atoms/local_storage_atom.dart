import 'package:asp/asp.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _sharedPreferences = getInstance();
Future<SharedPreferences> getInstance() async {
  return await SharedPreferences.getInstance();
}

final preferences = Atom(_sharedPreferences);
