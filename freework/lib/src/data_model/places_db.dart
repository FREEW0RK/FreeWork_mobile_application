import 'area_db.dart';
import 'user_db.dart';

/// The data associated with each place.
class PlacesData {
  PlacesData(
      {required this.id,
      required this.name,
      required this.description,
      required this.placeType,
      required this.editorID,
      required this.imagePath,
      required this.areaID,
      required this.lastUpdate,
      this.ownerID,
      List<String>? visitorIDs})
      : visitorIDs = visitorIDs ?? [];

  String id;
  String name;
  String placeType;
  String description;
  String imagePath;
  String editorID;
  String areaID;
  String lastUpdate;
  String? ownerID;
  List<String> visitorIDs;
}

/// Provides access to and operations on all defined Places.
class PlacesDB {
  final List<PlacesData> _places = [
    PlacesData(
        id: 'places-001',
        name: 'Alderwood Hill',
        description: '19 beds, 162 plantings (2022)',
        placeType: "public",
        imagePath: 'assets/images/diamond.png',
        editorID: 'user-001',
        areaID: 'area-001',
        lastUpdate: '11/15/22',
        ownerID: 'user-002',
        visitorIDs: ['user-003', 'user-005']),
    PlacesData(
        id: 'places-002',
        name: 'Kale is for Kids',
        description: '17 beds, 149 plantings (2022)',
        placeType: "community",
        imagePath: 'assets/images/diamond.png',
        areaID: 'area-001',
        lastUpdate: '10/10/22',
        editorID: 'user-002',
        visitorIDs: ['user-001', 'user-005']),
    PlacesData(
        id: 'places-003',
        name: 'Kaimake Loop',
        description: '1 bed, 5 plantings (2022)',
        placeType: "public",
        imagePath: 'assets/images/diamond.png',
        areaID: 'area-002',
        lastUpdate: '8/10/22',
        editorID: 'user-004',
        visitorIDs: ['user-005'],
        ownerID: 'user-003')
  ];
  




  PlacesData getPlace(String placeID) {
    return _places.firstWhere((data) => data.id == placeID);
  }

  List<String> getPlaceIDs() {
    return _places.map((data) => data.id).toList();
  }

  List<String> getAssociatedPlaceIDs({String? userID, String? areaID}) {
    if (userID != null) {
      return getPlaceIDs()
          .where((placeID) => _userIsAssociated(placeID, userID))
          .toList();
    }
    if (areaID != null) {
      return getPlaceIDs()
          .where((placeID) => getPlace(placeID).areaID == areaID)
          .toList();
    }
    return [];
  }



  List<String> getAssociatedUserIDs(placeID) {
    PlacesData data = placesDB.getPlace(placeID);
    List<String> associatedUserIDs = [
      data.editorID,
      ...data.visitorIDs,
    ];
    if (data.ownerID != null) {
      associatedUserIDs.add(data.ownerID!);
    }
    return associatedUserIDs;
  }


  bool _userIsAssociated(String placeID, String userID) {
    PlacesData data = getPlace(placeID);
    return ((data.editorID == userID) ||
        (data.visitorIDs.contains(userID)) ||
        (data.ownerID!.contains(userID)));
  }

  UserData? getOwner(String placeID) {
  PlacesData data = getPlace(placeID);
  if (data.ownerID != null) {
    return userDB.getUser(data.ownerID!);
  } else {
    // Handle the case where ownerID is null, e.g., return a default user or handle accordingly.
    return null; // or return a default user or perform other error handling.
  }
}

  List<UserData> getEditors(String placeID) {
    PlacesData data = getPlace(placeID);
    return userDB.getUsers(data.editorID as List<String>);
  }

  List<UserData> getVisitor(String placeID) {
    PlacesData data = getPlace(placeID);
    return userDB.getUsers(data.visitorIDs);
  }

  AreaData getArea(String placeID) {
    PlacesData data = getPlace(placeID);
    return areaDB.getArea(data.areaID);
  }
}

/// The singleton instance of a placeDB used by clients to access place data.
PlacesDB placesDB = PlacesDB();