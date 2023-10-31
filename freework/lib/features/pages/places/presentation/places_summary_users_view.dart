import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/places_db.dart';
import '../data/places_provider.dart';

import '../../../components/user_labeled_avatar.dart';

/// Provides a row of User avatars associated with a gardenID.
class PlacesSummaryUsersView extends ConsumerWidget {
  const PlacesSummaryUsersView({Key? key, required this.placeID})
      : super(key: key);

  final String placeID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlacesDB placesDB = ref.watch(placesDBProvider);
    PlacesData placeData = placesDB.getPlace(placeID);
    double padding = 10;

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
     /*  UserLabeledAvatar(
          userID: placeData.editorIDs, label: 'Owner', rightPadding: padding), */
      ...placeData.editorIDs
          .map((editorID) => UserLabeledAvatar(
              userID: editorID, label: 'Editor', rightPadding: padding))
          .toList(),
      ...placeData.visitorIDs
          .map((editorID) => UserLabeledAvatar(
              userID: editorID, label: 'Viewer', rightPadding: padding))
          .toList(),
    ]);
  }
}
