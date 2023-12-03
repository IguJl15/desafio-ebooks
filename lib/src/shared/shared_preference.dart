import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferenceSingleton {
  // Singleton props
  static SharedPreferences? _instance;
  static SharedPreferences get instance {
    if (_instance == null) throw Exception("SharedPreferences not initialized");
    return _instance!;
  }

  static Future<void> initialize() async => _instance = await SharedPreferences.getInstance();
}
