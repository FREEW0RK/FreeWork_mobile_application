import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import '../../chapter/data/chapter_providers.dart';
//import '../../chapter/domain/chapter_db.dart';
import '../../places/data/places_provider.dart';
import '../../places/domain/places_db.dart';

import '../data/user_providers.dart';
import '../domain/user..dart';
import 'package:freework/features/user/data/user_providers.dart';
import 'user_avatar.dart';

// A Card that summarizes information about a User.
class UserCardView extends ConsumerWidget {
  const UserCardView({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserDB userDB = ref.watch(userDBProvider);
    final PlacesDB placesDB = ref.watch(placesDBProvider);
    //final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    UserData data = userDB.getUser(userID);
    List<String> placesNames = placesDB
        .getAssociatedPlaceIDs(userID: userID)
        .map((placeID) => placesDB.getPlace(placeID))
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
