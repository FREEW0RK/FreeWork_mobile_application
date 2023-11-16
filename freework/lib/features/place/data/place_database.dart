import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';
import '../domain/place.dart';

/// Provides access to the Firestore database storing [Place] documents.
class PlacesDatabase {
  PlacesDatabase(this.ref);

  final ProviderRef<PlacesDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<Place>> watchPlaces() => _service.watchCollection(
      path: FirestorePath.places(),
      builder: (data, documentId) => Place.fromJson(data!));

  Stream<Place> watchPlace(String placeId) => _service.watchDocument(
      path: FirestorePath.place(placeId),
      builder: (data, documentId) => Place.fromJson(data!));

  Future<List<Place>> fetchPlaces() => _service.fetchCollection(
      path: FirestorePath.places(),
      builder: (data, documentId) => Place.fromJson(data!));

  Future<Place> fetchPlace(String placeId) => _service.fetchDocument(
      path: FirestorePath.place(placeId),
      builder: (data, documentId) => Place.fromJson(data!));

  Future<void> setPlace(Place place) => _service.setData(
      path: FirestorePath.place(place.id), data: place.toJson());

  Future<void> setPlaceDelayed(Place place) => Future.delayed(
      const Duration(milliseconds: 2000),
      () => _service.setData(
          path: FirestorePath.place(place.id), data: place.toJson()));

  Future<void> setPlaceError(Place place) =>
      Future.delayed(const Duration(milliseconds: 2000), () => throw Error());

  Future<void> deletePlace(Place place) =>
      _service.deleteData(path: FirestorePath.place(place.id));
}
