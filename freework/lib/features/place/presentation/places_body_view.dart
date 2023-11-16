import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../fw_error.dart';
import '../../fw_loading.dart';
import '../../all_data_provider.dart';
import '../domain/place.dart';
import '../domain/place_collection.dart';
import 'places_summary_view.dart';

/// Builds a list of [placeSummaryView].
class placeBodyView extends ConsumerWidget {
  const placeBodyView({
    super.key,
  });

  final String title = 'places';

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
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
            children: placeCollection
                .getAssociatedPlaces(userID: currentUserID)
                .map((place) => PlaceSummaryView(place: place))
                .toList()));
  }
}
