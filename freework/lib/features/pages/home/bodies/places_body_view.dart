import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/places_summary_view.dart';
import '../../../data_model/places_db.dart';
import '../../../data_model/user_db.dart';

/// Displays a list of Nice Spots.
class PlacesBodyView extends ConsumerWidget {
  const PlacesBodyView({
    super.key,
  });

  final String title = 'Nice Spots';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlacesDB placesDB = ref.watch(placesDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
            children: placesDB
                .getAssociatedPlaceIDs(userID: currentUserID)
                .map((placeID) => PlacesSummaryView(placeID: placeID))
                .toList()
                .toList()));
  }
}
