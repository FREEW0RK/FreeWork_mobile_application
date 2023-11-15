import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/place.dart';
import 'place_database.dart';

part 'place_provider.g.dart';

@riverpod
PlaceDatabase placeDatabase(PlaceDatabaseRef ref) {
  return PlaceDatabase(ref);
}

@riverpod
Stream<List<Place>> place(PlacesRef ref) {
  final database = ref.watch(placeDatabaseProvider);
  return database.watchplacess();
}






// Old way:
// final placesDatabaseProvider = Provider<placesDatabase>((ref) {
//   return placesDatabase(ref);
// });
//
// final placessProvider = StreamProvider<List<places>>((ref) {
//   final database = ref.watch(placesDatabaseProvider);
//   return database.watchplacess();
// });
