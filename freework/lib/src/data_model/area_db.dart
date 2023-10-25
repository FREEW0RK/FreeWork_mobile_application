import 'places_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// The data associated with each chapter.
class AreaData {
  AreaData({
    required this.id,
    required this.name,
    this.imagePath,
    required this.weatherServiceAreaZones,
    required this.zipCodes});

  String id;
  String name;
  String? imagePath;
  String weatherServiceAreaZones;
  List<String> zipCodes;
}

/// Provides access to and operations on all defined Chapters.
class AreaDB {
  AreaDB(this.ref);
  final ProviderRef<AreaDB> ref;
  final List<AreaData> _areas = [
    AreaData(
        id: 'chapter-001',
        name: 'Bellingham, WA',
        zipCodes: ['98225', '98226', '98227', '98228', '98229'],
        imagePath: 'assets/images/diamond.png',
        weatherServiceAreaZones: 'Honolulu'
        ),
    AreaData(
        id: 'chapter-002',
        name: 'Kailua, HI',
        zipCodes: ['98734'],
        imagePath: 'assets/images/diamond.png',
        weatherServiceAreaZones: "NS Oahu "
    ),
  ];




  AreaData getArea(String areaID) {
    return _areas.firstWhere((data) => data.id == areaID);
  }

  List<String> getAreaIDs() {
    return _areas.map((data) => data.id).toList();
  }

  List<String> getAssociatedAreaIDs(String userID) {
    final PlacesDB placesDB = ref.watch(placesDBProvider);
    List<String> placeIDs = placesDB.getAssociatedPlaceIDs(userID: userID);
    Set<String> areaIDs = {};
    for (var placeID in placeIDs) {
      areaIDs.add(placesDB.getPlace(placeID).areaID);
    }
    return areaIDs.toList();
  }

  List<String> getAssociatedUserIDs(String areaID) {
    final PlacesDB placesDB = ref.watch(placesDBProvider);
    List<String> placeIDs = placesDB.getAssociatedPlaceIDs(areaID: areaID);
    Set<String> userIDs = {};
    for (var placeID in placeIDs) {
      userIDs.addAll(placesDB.getAssociatedUserIDs(placeID));
    }
    return userIDs.toList();
  }
}



final areaDBProvider = Provider<AreaDB>((ref) {
  return AreaDB(ref);
});





/// The singleton instance of a ChapterDB used by clients to access Chapter data.
//AreaDB areaDB = AreaDB();
