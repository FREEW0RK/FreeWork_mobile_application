import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'chapter/data/chapter_provider.dart';
import 'chapter/domain/chapter.dart';
import 'garden/data/garden_provider.dart';
import 'garden/domain/garden.dart';
import 'news/data/news_provider.dart';
import 'news/domain/news.dart';
import 'user/data/user_providers.dart';
import 'user/domain/user.dart';

//part 'all_data_provider.g.dart';

// Based on: https://stackoverflow.com/questions/69929734/combining-futureproviders-using-a-futureprovider-riverpod

class AllData {
  AllData(
      {required this.chapters,
      required this.gardens,
      required this.users,
      required this.news,
      required this.currentUserID});

  final List<Chapter> chapters;
  final List<Garden> gardens;
  final List<User> users;
  final List<News> news;
  final String currentUserID;
}

@riverpod
Future<AllData> allData(AllDataRef ref) async {
  final chapters = ref.watch(chaptersProvider.future);
  final gardens = ref.watch(gardensProvider.future);
  final users = ref.watch(usersProvider.future);
  final news = ref.watch(newsProvider.future);
  final currentUserID = ref.watch(currentUserIDProvider);
  return AllData(
      chapters: await chapters,
      gardens: await gardens,
      users: await users,
      news: await news,
      currentUserID: currentUserID);
}
