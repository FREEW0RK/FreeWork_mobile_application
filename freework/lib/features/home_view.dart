import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'drawer_view.dart';
import 'help/presentation/help_button.dart';
import 'place/domain/place.dart';
import 'place/domain/place_collection.dart';

import 'place/presentation/places_body_view.dart';


import 'fw_error.dart';
import 'fw_loading.dart';
import 'all_data_provider.dart';

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
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
            context: context,
            currentUserID: allData.currentUserID,
            //news: allData.news,
            places: allData.places),
        loading: () => const FWLoading(),
        error: (error, st) => FWError(error.toString(), st.toString()));
  }

  
  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      //required List<News> news,
      required List<Place> places}) {
    final placeCollection = PlaceCollection(places);
    //final newsCollection = NewsCollection(news);
    /*  String numNews =
        newsCollection.getAssociatedNewsIDs(currentUserID).length.toString(); */
    String numPlaces = placeCollection
        .getAssociatedPlaceIDs(userID: currentUserID)
        .length
        .toString();
    //String numDiscussions = 0.toString();

    // This data structure will eventually become stateful and thus will
    // need to be moved into the state widget.
    final Map pages = {
      0: {
        'title': const Text('Nice Spots'),
        'body': const PlaceBodyView(),
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
