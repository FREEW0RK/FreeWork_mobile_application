
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide ForgotPasswordView;
import 'package:flex_color_scheme/flex_color_scheme.dart';



import 'app.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode


import 'features/settings/presentation/settings_view.dart';
import 'package:freework/features/places/presentation/places_view.dart';
import 'package:freework/features/poll/presentation/poll.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/pages/sample_feature/sample_item_details_view.dart';
import 'features/pages/sample_feature/sample_item_list_view.dart';
import 'package:freework/features/home_view.dart';
import 'package:freework/features/authentication/presentation/login_view_video.dart';
import 'package:freework/features/authentication/presentation/signup_view.dart';
import 'package:freework/features/map/presentation/main_map.dart';
import 'package:freework/features/start/presentation/start.dart';
import 'package:freework/features/places/presentation/add_places_view.dart';
import 'package:freework/features/places/presentation/edit_place_view.dart';


import 'features/authentication/presentation/forgot_password_view.dart';
import 'features/authentication/presentation/signin_view.dart';
import 'features/authentication/presentation/verify_email_view.dart';
import 'features/chapter/domain/chapter.dart';
import 'features/chapter/presentation/chapters_view.dart';
import 'features/discussion/presentation/discussions_view.dart';
import 'features/garden/domain/garden.dart';
import 'features/garden/presentation/add_garden_view.dart';
import 'features/garden/presentation/edit_garden_view.dart';
import 'features/garden/presentation/gardens_view.dart';
import 'features/global_snackbar.dart';
import 'features/help/presentation/help_view.dart';
import 'features/help/presentation/help_view_local.dart';
import 'features/home_view.dart';
import 'features/news/domain/news.dart';
import 'features/outcome/presentation/outcomes_view.dart';
import 'features/page_not_found_view.dart';
import 'features/seed/presentation/seeds_view.dart';
import 'features/settings/data/settings_db.dart';
import 'features/settings/presentation/settings_view.dart';
import 'features/user/domain/user.dart';
import 'features/user/presentation/users_view.dart';
import 'firebase_options.dart';


// Check that Freezed data models and json data files are compatible.
Future<bool> verifyInitialData() async {
  // logger.i('Verifying initial data files: Chapter, Garden, News, User');
  //await Chapter.checkInitialData();
  await Places.checkInitialData();
  //await News.checkInitialData();
  await User.checkInitialData();
  return true;
}
//GRADLE DEBUG COMMAND
////https://stackoverflow.com/questions/64734646/failed-to-delete-some-children-this-might-happen-because-a-process-has-files-op

void main() async {
  // Find and load the Appainter-generated theme
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  await verifyInitialData();

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
  runApp(const ProviderScope(child:MyApp()));
}







