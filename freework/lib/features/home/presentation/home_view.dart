import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/drawer_view.dart';
import '../../help/presentation/help_button.dart';
import '../../places/domain/places_db.dart';
import '../../places/data/places_provider.dart';

import '../../user/domain/user_db.dart';
import 'bodies/places_body_view.dart';
import 'package:freework/features/user/data/user_providers.dart';


//import '../../data_model/news_db.dart';
//import 'bodies/chapter_body_view.dart';
//import 'bodies/news_body_view.dart';


/// Top-level Layout for all of the "Home" related subpages.
class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  static const routeName = '/home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final PlacesDB placesDB = ref.watch(placesDBProvider);
    //final NewsDB newsDB = ref.watch(newsDBProvider);
    //String numNews =
      //  newsDB.getAssociatedNewsIDs(currentUserID).length.toString();
    String numPlaces = placesDB
        .getAssociatedPlaceIDs(userID: currentUserID)
        .length
        .toString();
    //String numDiscussions = 0.toString();



    // This data structure will eventually become stateful and thus will
    // need to be moved into the state widget.
    final Map<int, Map<String, dynamic>> pages = {
      0: {
        'title': const Text('Nice Spots'),
        'body': const PlacesBodyView(),
        'navItem': BottomNavigationBarItem(
          label: 'My Nice Spots ($numPlaces)',
          icon: const Icon(Icons.beach_access_sharp),
        ),
        
      },
    };
/* 
    final Map pages = {
      /* 0: {
        'title': const Text('News'),
        'body': const NewsBodyView(),
        'navItem': BottomNavigationBarItem(
          label: 'My News ($numNews)',
          icon: const Icon(Icons.newspaper),
        ),
      },*/
      1: {
        'title': const Text('Nice Spots'),
        'body': const PlacesBodyView(),
        'navItem': BottomNavigationBarItem(
          label: 'My Nice Spots ($numPlaces)',
          icon: const Icon(Icons.location_pin),
        ),
      },
      /*
      2: {
        'title': const Text('Chapter'),
        'body': const ChapterBodyView(),
        'navItem': BottomNavigationBarItem(
          label: 'My Discussions ($numDiscussions)',
          icon: const Icon(Icons.chat),
        ),
      },*/
    }; 
 */



    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: const Text('Home'),
        actions: const [HelpButton(routeName: HomeView.routeName)],
      ),
      body: pages[_selectedIndex]?['body'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // needed when more than 3 items
        items: [
          pages[0]?['navItem'],
          pages[0]?['navItem'],
          pages[0]?['navItem'],
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
