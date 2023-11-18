import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../fw_error.dart';
import '../../fw_loading.dart';
import '../../all_data_provider.dart';

import '../../user/presentation/user_labeled_avatar.dart';

import '../domain/place.dart';
import '../domain/place_collection.dart';



/// Provides a row of User avatars associated with a gardenID.
class PlaceSummaryUsersView extends ConsumerWidget {
  const PlaceSummaryUsersView({Key? key, required this.placeID})
      : super(key: key);

  final String placeID;

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
    double padding = 10;
    Place place = PlaceCollection(places).getPlace(placeID);
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      UserLabeledAvatar(
          userID: place.ownerID, label: 'Owner', rightPadding: padding),
      ...place.editorIDs
          .map((editorID) => UserLabeledAvatar(
              userID: editorID, label: 'Editor', rightPadding: padding))
          .toList(),
      ...place.visitorIDs
          .map((editorID) => UserLabeledAvatar(
              userID: editorID, label: 'Viewer', rightPadding: padding))
          .toList(),
    ]);
  }
}
