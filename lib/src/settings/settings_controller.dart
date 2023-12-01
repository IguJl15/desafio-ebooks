import 'package:flutter/material.dart';

import 'settings_service.dart';

class SettingsController extends ChangeNotifier {

  // Singleton props
  static SettingsController? _instance;
  static SettingsController get instance {
    if (_instance == null) throw Exception("Settings controller not initialized");
    return _instance!;
  }

  static void initialize(SettingsService service) => _instance = SettingsController._(service);

  SettingsController._(this._settingsService);

  final SettingsService _settingsService;

  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }
}
