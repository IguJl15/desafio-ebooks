import 'dart:io';

import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/ebooks/data/ebook_downloads_controller.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'src/shared/shared_preference.dart';

void main() async {
  // On mobile, crashes at initialization
  if (Platform.isAndroid || Platform.isIOS) {
    WidgetsFlutterBinding.ensureInitialized();
  }

  SettingsController.initialize(SettingsService());
  await AppSharedPreferenceSingleton.initialize();
  await EbookDownloadsController.initialize();

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await SettingsController.instance.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: SettingsController.instance));
}
