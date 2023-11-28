import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide ForgotPasswordView;
import 'package:freework/features/authentication/presentation/forgot_password_view.dart';


import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode


import 'features/settings/presentation/settings_view.dart';
import 'package:freework/features/place/presentation/places_view.dart';
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
import 'package:freework/features/place/presentation/add_place_view.dart';
import 'package:freework/features/place/presentation/edit_place_view.dart';


/* import 'features/chapter/domain/chapter.dart';
import 'features/chapter/presentation/chapters_view.dart';
import 'features/discussion/presentation/discussions_view.dart';
import 'features/news/domain/news.dart';
import 'features/outcome/presentation/outcomes_view.dart';
import 'features/page_not_found_view.dart';
import 'features/seed/presentation/seeds_view.dart'; */

import 'features/place/domain/place.dart';
import 'features/user/domain/user.dart';
import 'firebase_options.dart';


// Check that Freezed data models and json data files are compatible.
Future<bool> verifyInitialData() async {
  // logger.i('Verifying initial data files: Chapter, place, News, User');
  //await Chapter.checkInitialData();
  await Place.checkInitialData();
  //await News.checkInitialData();
  await User.checkInitialData();
  return true;
}


//GRADLE DEBUG COMMAND
////https://stackoverflow.com/questions/64734646/failed-to-delete-some-children-this-might-happen-because-a-process-has-files-op

void main() async {
  // Find and load the Appainter-generated  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  final themeStr = await rootBundle.loadString('assets/theme/appainter_theme_green1.json');
  await verifyInitialData();
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  runApp(const ProviderScope(child:MyApp()));
}


/// The Widget that configures your application.
class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(currentThemeProvider);
    final systemTheme = ref.watch(systemThemeDataProvider);

    return MaterialApp(
      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: systemTheme.value,
      themeMode: currentTheme,
      darkTheme: ThemeData.dark(),

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
                case SettingsView.routeName:
                    return const SettingsView();
                case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                case SampleItemListView.routeName:
                    return const SampleItemListView();
                case MainMap.routeName:
                    return const MainMap();    
                case PollingPage.routeName:
                    return const PollingPage();
                case SignupView.routeName:
                    return const SignupView();
                case SigninView.routeName:
                    return const SigninView();
                case ForgotPasswordView.routeName:
                    return const ForgotPasswordView();       
                case PlaceView.routeName:
                    return const PlaceView();
                case AddPlaceView.routeName:
                    return AddPlaceView();
                case EditPlaceView.routeName:
                    return EditPlaceView();
                case HomeView.routeName:
                    return const HomeView();
                case StartPage.routeName:
                    return const StartPage();
                default:
                    return const SigninView();
                    
                }
              },
            );
          },
        );

  }
}



  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  //final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  //await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.









