import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/* 
import '../../chapter/domain/chapter.dart';
import '../../chapter/domain/chapter_collection.dart'; */
//import '../../chapter/data/chapter_providers.dart';
//import '../../chapter/domain/chapter_db.dart';
import '../../fw_error.dart';
import '../../fw_loading.dart';
import '../../all_data_provider.dart';
import '../../place/domain/place.dart';
import '../../place/domain/place_collection.dart';
import '../domain/user.dart';
import 'user_avatar.dart';



// A Card that summarizes information about a User.
class UserCardView extends ConsumerWidget {
  const UserCardView({Key? key, required this.user}) : super(key: key);

  final User user;


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
      required List<Place> places,
      //required List<Chapter> chapters 
    }) {
    PlaceCollection placeCollection = PlaceCollection(places);
    //ChapterCollection chapterCollection = ChapterCollection(chapters);
    List<String> placeNames = placeCollection
        .getAssociatedPlaceIDs(userID: user.id)
        .map((placeID) => placeCollection.getPlace(placeID))
        .map((placeData) =>placeData.name)
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
                  leading: UserAvatar(userID: user.id),
                  trailing: const Icon(Icons.more_vert),
                  title: Text(user.username,
                      style: Theme.of(context).textTheme.titleLarge)),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Nice Spots(s): ${placeNames.join(", ")}')),
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
