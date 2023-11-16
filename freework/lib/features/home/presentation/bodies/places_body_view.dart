import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../place/data/place_provider.dart';
import '../../../place/domain/place.dart';
import '../../../place/domain/place_collection.dart';





/// Displays a list of Nice Spots.
class PlaceBodyView extends ConsumerWidget {
  const PlaceBodyView({
    super.key,
  });

  final String title = 'Nice Spots';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Place place = ref.watch(placeProvider);
    final String currentUserID = ref.watch(currentUserID);
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
            children: place
                .getAssociatedPlaceIDs(userID: currentUserID)
                .map((placeID) => PlaceSummaryView(placeID: placeID))
                .toList()
                .toList()));
  }
}
