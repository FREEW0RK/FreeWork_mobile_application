import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import '../data_model/chapter_db.dart';
import '../domain/places_db.dart';


import 'edit_place_view.dart';

enum PlaceAction { edit, leave }

/// Provides a Card summarizing a garden.
class PlaceSummaryView extends ConsumerWidget {
  const PlaceSummaryView({Key? key, required this.placeID}) : super(key: key);

  final String placeID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlacesDB placesDB = ref.watch(placesProvider);
    //final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    PlacesData placesData = placesDB.getPlace(placeID);
    String title = placesData.name;
    String subtitle = placesData.description;
    String location = placesData.location;
    String lastUpdate = placesData.lastUpdate;
    String imagePath = placesData.imagePath;
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
