import 'package:flutter/material.dart';
import '../../fw_error.dart';
import '../../fw_loading.dart';
import '../../all_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../drawer_view.dart';
import 'place_summary_view.dart';
import '../../help/presentation/help_button.dart';

import 'add_place_view.dart';

import '../domain/place.dart';
import '../domain/place_collection.dart';

const pageSpecification = '''
# Gardens Page Specification

## Motivation/Goals

This page has two top-level tabs:

* The first provides access to both the user's own gardens (i.e. the ones they are the owner of, or an editor of, or a viewer or). This is equivalent to the "My Gardens" tab in the Home page.

* The second provides access to all of the gardens in all of the Chapters. This could get large.

## Contents 

Probably want to start with a dismissable documentation card at the top that explains the idea behind Gardens, and/or how to navigate. 

Then a set of cards, one per Garden, each containing a summary of the garden.

Clicking on a card takes you to a more detailed view of the garden? 

## Actions 

Possible actions associated with each card:

* Edit the garden associated with the Card.

## Issues

* Should there be an expandable card to provide more details about a garden for those gardens that are not yours?

''';

/// Provides a page presenting all of the defined Nice FW Spots.
class PlaceView extends ConsumerWidget {
  const PlaceView({
    super.key,
  });

  //final String title = 'Nice Spots';
  static const routeName = '/places';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
            context: context,
            currentUserID: allData.currentUserID,
            places: allData.places),
        loading: () => const FWLoading(),
        error: (error, st) => FWError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      required List<Place> places}) {
    PlaceCollection placeCollection = PlaceCollection(places);
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: Text('Nice Spots (${placeCollection.size()})'),
        actions: const [HelpButton(routeName: PlaceView.routeName)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.restorablePushNamed(context, AddPlaceView.routeName);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
              children: placeCollection
                  .getAssociatedPlaces(userID: currentUserID)
                  .map((place) => PlaceSummaryView(place: place))
                  .toList())),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[],
        ),
      ),
    );
  }
}
