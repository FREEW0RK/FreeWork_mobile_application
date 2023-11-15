import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import '../../chapter/data/chapter_providers.dart';
//import '../../chapter/domain/chapter_db.dart';
import '../../places/data/place_provider.dart';
import '../../places/domain/places_db.dart';

import '../data/user_providers.dart';
import '../domain/user.dart';
import '../domain/user_collection.dart';

import 'user_avatar.dart';

// A Card that summarizes information about a User.
class UserCardView extends ConsumerWidget {
  const UserCardView({Key? key, required this.user}) : super(key: key);

  final String user;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
            context: context,
            currentUserID: allData.currentUserID,
            //chapters: allData.chapters,
            places: allData.places),
        loading: () => const FWLoading(),
        error: (error, st) => FWError(error.toString(), st.toString()));
  }
/* 
    final Places places = ref.watch(placesProvider);
    final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    User data = user.getUser(userID); */

  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      required List<Places> places,
      //required List<Chapter> chapters}) {
    PlacesCollection placesCollection = PlacesCollection(places);
    //ChapterCollection chapterCollection = ChapterCollection(chapters);
    List<String> placesNames = places
        .getAssociatedPlaceIs(userID: userID)
        .map((placeID) => places.getPlace(placeID))
        .map((placesData) => placesData.name)
        .toList();
    /* List<String> chapterNames = chapterDB
        .getAssociatedChapterIDs(userID)
        .map((chapterID) => chapterDB.getChapter(chapterID))
        .map((chapterData) => chapterData.name)
        .toList(); */
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 8,
          child: Column(
            children: [
              ListTile(
                  leading: UserAvatar(userID: userID),
                  trailing: const Icon(Icons.more_vert),
                  title: Text(data.username,
                      style: Theme.of(context).textTheme.titleLarge)),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Places(s): ${placesNames.join(", ")}')),
              ),/* 
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Chapter(s): ${chapterNames.join(", ")}')),
              ), */
              const SizedBox(height: 10)
            ],
          )),
    );
  }
}
