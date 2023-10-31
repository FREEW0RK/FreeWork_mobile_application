import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/places_db.dart';


final placesDBProvider = Provider<PlacesDB>((ref) {
  return PlacesDB(ref);
});
