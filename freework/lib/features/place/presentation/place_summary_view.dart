import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import '../data_model/chapter_db.dart';
import '../domain/places_db.dart';
import '../domain/place.dart';
import '../domain/place_collection.dart';

import '../data/place_provider.dart';
import 'place_summary_users_view.dart';
import 'edit_place_view.dart';
import 'edit_place_controller.dart';


import '../../global_snackbar.dart';
import '../../fw_error.dart';
import '../../fw_loading.dart';
import '../../all_data_provider.dart';

enum PlaceAction { edit, delete }

/// Provides a Card summarizing a garden.
class PlaceSummaryView extends ConsumerWidget {
  const PlaceSummaryView({Key? key, required this.place}) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
            context: context,
            ref: ref,
            currentUserID: allData.currentUserID,
            //chapters: allData.chapters,
            places: allData.places),
        loading: () => const FWLoading(),
        error: (error, st) => FWError(error.toString(), st.toString()));
  }

  // Handle the "Delete" dropdown selection.
  Future<void> _onDelete(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This Spot will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  
    if (result == null || !result) {
      return;
    }
    ref.read(editPlaceControllerProvider.notifier).deletePlace(
        place: place,
        onSuccess: () {
          GlobalSnackBar.show('Spot "${place.name}" deleted.');
        });
  }


  // Handle the "Edit" dropdown selection.
  Future<void> _onEdit(BuildContext context) async {
    Navigator.restorablePushNamed(context, EditPlaceView.routeName,
        arguments: place.id);
  }



  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      required List<Place> places,
      //required List<Chapter> chapters,
      required WidgetRef ref}) {
    PlaceCollection placeCollection = PlaceCollection(places);
    //ChapterCollection chapterCollection = ChapterCollection(chapters);
    String title = place.name;
    String subtitle = place.description;
    String lastUpdate = place.lastUpdate;
    String imagePath = place.imagePath;
   /*  String chapterName = chapterCollection
        .getChapterFromGardenID(garden.id, gardenCollection)
        .name; */
    AssetImage image = AssetImage(imagePath);
    return Card(
      elevation: 9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            isThreeLine: true,
            title: Text(title),
            subtitle: Text('$subtitle\n$title Place'),
            trailing: PopupMenuButton<PlaceAction>(
              // Callback that sets the selected popup menu item.
              onSelected: (PlaceAction action) {
                if (action == PlaceAction.edit) {
                  _onEdit(context);
                } else if (action == PlaceAction.delete) {
                  _onDelete(context, ref);
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<PlaceAction>>[
                const PopupMenuItem<PlaceAction>(
                  value: PlaceAction.edit,
                  child: Text('Edit'),
                ),
                const PopupMenuItem<PlaceAction>(
                  value: PlaceAction.delete,
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150.0,
            child: Ink.image(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          PlaceSummaryUsersView(placeID: place.id),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text('Last updated: $lastUpdate')),
          ),
        ],
      ),
    );
  }
}


/* 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Place place = ref.watch(placeProvider);
    //final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    PlaceData placeData = place.getPlace(placeID);
    String title = placeData.name;
    String subtitle = placeData.description;
    String location = placeData.location;
    String lastUpdate = placeData.lastUpdate;
    String imagePath = placeData.imagePath;
    //String chapterName = chapterDB.getChapterFromGardenID(gardenID).name;
    AssetImage image = AssetImage(imagePath);
    return Card(
      elevation: 9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            isThreeLine: true,
            title: Text(title),
            subtitle: Text('$subtitle\n$location Location'),
            trailing: PopupMenuButton<PlaceAction>(
              // Callback that sets the selected popup menu item.
              onSelected: (PlaceAction action) {
                if (action == PlaceAction.edit) {
                  Navigator.restorablePushNamed(
                      context, EditPlaceView.routeName,
                      arguments: placeID);
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<PlaceAction>>[
                const PopupMenuItem<PlaceAction>(
                  value: PlaceAction.edit,
                  child: Text('Edit'),
                ),
                const PopupMenuItem<PlaceAction>(
                  value: PlaceAction.leave,
                  child: Text('Leave'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150.0,
            child: Ink.image(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          PlaceSummaryUsersView(placeID: placeID),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text('Last updated: $lastUpdate')),
          ),
        ],
      ),
    );
  }
}
 */