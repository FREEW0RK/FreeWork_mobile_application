
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'features/pages/settings/settings_controller.dart';
import 'features/pages/settings/settings_service.dart';

import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode


//GRADLE DEBUG COMMAND
////https://stackoverflow.com/questions/64734646/failed-to-delete-some-children-this-might-happen-because-a-process-has-files-op

void main() async {
  // Find and load the Appainter-generated theme
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/theme/appainter_theme_green1.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  //final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  //await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(ProviderScope(child:MyApp()));
}







