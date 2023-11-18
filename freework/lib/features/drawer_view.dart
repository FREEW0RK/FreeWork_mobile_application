import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fw_error.dart';
import 'fw_loading.dart';
import 'all_data_provider.dart';


import 'user/domain/user.dart';
import 'user/domain/user_collection.dart';
import 'user/presentation/user_avatar.dart';

import 'settings/presentation/settings_view.dart';
import 'help/presentation/help_view.dart';
import 'home_view.dart';
import 'place/presentation/places_view.dart';

/* 
import 'outcome/presentation/outcomes_view.dart';
import 'seed/presentation/seeds_view.dart';
 */



/// Builds the drop-down Drawer with the menu of top-level pages.
class DrawerView extends ConsumerWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
            context: context,
            currentUserID: allData.currentUserID,
            users: allData.users),
        loading: () => const FWLoading(),
        error: (error, st) => FWError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context,
      required List<User> users,
      required String currentUserID}) {
    UserCollection userCollection = UserCollection(users);
    User user = userCollection.getUser(currentUserID);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.id),
            currentAccountPicture: UserAvatar(userID: user.id),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.beach_access_sharp),
            title: const Text('Nice FW Spot'),
            onTap: () {
              Navigator.pushReplacementNamed(context, PlaceView.routeName);
            },
           ),
         /* ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Members'),
            onTap: () {
              Navigator.pushReplacementNamed(context, UsersView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.groups),
            title: const Text('Chapters'),
            onTap: () {
              Navigator.pushReplacementNamed(context, ChaptersView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.trending_up),
            title: const Text('Outcomes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OutcomesView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.water_drop_outlined),
            title: const Text('Seeds'),
            onTap: () {
              Navigator.pushReplacementNamed(context, SeedsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Discussions'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, DiscussionsView.routeName);
            }, 
          ),*/
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HelpView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushReplacementNamed(context, SettingsView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'bad page');
            },
          ),
        ],
      ),
    );
  }
}
