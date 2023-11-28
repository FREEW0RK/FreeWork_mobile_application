import 'package:riverpod_annotation/riverpod_annotation.dart';

/* import 'chapter/data/chapter_provider.dart';
import 'chapter/domain/chapter.dart';
import 'news/data/news_provider.dart';
import 'news/domain/news.dart'; */

import 'place/data/place_provider.dart';
import 'place/domain/place.dart';

import 'user/data/user_providers.dart';
import 'user/domain/user.dart';

part 'all_data_provider.g.dart';

// Based on: https://stackoverflow.com/questions/69929734/combining-futureproviders-using-a-futureprovider-riverpod

class AllData {
  AllData(
      {/* required this.chapters,
      required this.news, */

      required this.places,
      required this.users,
      required this.currentUserID});

 /*  final List<Chapter> chapters;
  final List<News> news; */

  final List<Place> places;
  final List<User> users;
  final String currentUserID;
}



/* @riverpod
Future<AllData> allData(AllDataRef ref) async {
  try {
    /* final chapters = await ref.watch(chaptersProvider.future);
    final news = await ref.watch(newsProvider.future); */

    final places = await ref.watch(placeProvider.future);
    final users = await ref.watch(usersProvider.future);

    // Use null-aware operator to provide a default value for currentUserID
    final currentUserID = ref.watch(currentUserIDProvider) ?? 'user-005';

  

    // Perform null checks on the fetched data
    /* if (chapters == null || news == null || places == null || users == null) {
      // Handle the case where any of the data is null
      throw Exception('Failed to fetch all data');
    } */

    if (places == null || users == null) {
      // Handle the case where any of the data is null
      throw Exception('Failed to fetch all data');
    }

    return AllData(
      /* chapters: chapters,
      news: news, */
      places: places,
      users: users,
      currentUserID: currentUserID,
    );

  } catch (e) {
    // Handle the error, log, or rethrow if necessary
    print('Error fetching all data: $e');
    rethrow;
  }
} */

@riverpod
Future<AllData> allData(AllDataRef ref) async {
  /* final chapters = ref.watch(chaptersProvider.future);
  final news = ref.watch(newsProvider.future); */

  final places = ref.watch(placeProvider.future);
  final users = ref.watch(usersProvider.future);
  final currentUserID = ref.watch(currentUserIDProvider);
  return AllData(
      /* chapters: await chapters,
      news: await news, */

      places: await places,
      users: await users,
      currentUserID: currentUserID);
}
 