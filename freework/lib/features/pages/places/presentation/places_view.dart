import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/drawer_view.dart';
import 'places_summary_view.dart';
import '../../../components/help_button.dart';
import '../domain/places_db.dart';
import '../data/places_provider.dart';


import '../../../data_model/user_db.dart';
import 'add_places_view.dart';

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
class PlacesView extends ConsumerWidget {
  const PlacesView({
    super.key,
  });

  final String title = 'Nice Spots';
  static const routeName = '/places';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlacesDB placesDB = ref.watch(placesDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    return Scaffold(
      drawer: const DrawerView(),
      appBar: AppBar(
        title: const Text('Nice Spots'),
        actions: const [HelpButton(routeName: PlacesView.routeName)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.restorablePushNamed(context, AddPlacesView.routeName);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
              children: placesDB
                  .getAssociatedPlaceIDs(userID: currentUserID)
                  .map((placeID) => PlacesSummaryView(placeID: placeID))
                  .toList()
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
