import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/settings/presentation/settings_controller.dart';
import 'features/settings/presentation/settings_view.dart';

import 'package:freework/features/places/presentation/places_view.dart';
import 'package:freework/features/poll/presentation/poll.dart';


//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/pages/sample_feature/sample_item_details_view.dart';
import 'features/pages/sample_feature/sample_item_list_view.dart';


import 'package:freework/features/home/presentation/home_view.dart';
import 'package:freework/features/authentication/presentation/login_view_video.dart';
import 'package:freework/features/authentication/presentation/signup_view.dart';
import 'package:freework/features/map/presentation/main_map.dart';
import 'package:freework/features/start/presentation/start.dart';


import 'package:freework/features/places/presentation/places_view.dart';
import 'package:freework/features/places/presentation/add_places_view.dart';
import 'package:freework/features/places/presentation/edit_place_view.dart';



/// The Widget that configures your application.
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
                case PlacesView.routeName:
                    return const PlacesView();
                case AddPlacesView.routeName:
                    return AddPlacesView();
                case EditPlaceView.routeName:
                    return EditPlaceView();
                case SigninView.routeName:
                    return const SigninView();
                case HomeView.routeName:
                    return const HomeView();
                case StartPage.routeName:
                    return const StartPage();
                default:
                    return const HomeView();
                }
              },
            );
          },
        );

  }
}



 /*   // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
 */