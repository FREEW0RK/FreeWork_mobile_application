import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
//import 'area_db.dart';
import 'package:freework/features/user/data/user_providers.dart';



/// The data associated with each place.
class PlacesData {
  PlacesData(
      {required this.id,
      required this.name,
      required this.description,      
      required this.location,
      //List<String> location = const [],
      required this.placeType,
      required this.imagePath,
      String? areaID,
      required this.lastUpdate,
      this.ownerID,
      List<String>? editorIDs,
      List<String>? visitorIDs})
      : editorIDs = editorIDs ?? [],
        //location = location ?? [],
        visitorIDs = visitorIDs ?? [];

  String id;
  String name;
  String description;
  String location;
  String placeType;
  String imagePath;
  String? areaID;
  String lastUpdate;
  String? ownerID;
  List<String> editorIDs;
  List<String> visitorIDs;


  @override
  String toString() {
    return '<PlaceData id: $id, name: $name, description: $description, imagePath: $imagePath, ownerID: $ownerID, location ccordinates: $location, lastUpdate: $lastUpdate, editorIDs: ${editorIDs
        .toString()}, viewerIDs: ${visitorIDs.toString()}>';
  }

}

/// Provides access to and operations on all defined Places.
class PlacesDB {
  PlacesDB(this.ref);

  final ProviderRef<PlacesDB> ref;
  final List<PlacesData> _places = [
    PlacesData(
        id: 'places-001',
        name: 'University of Hawaii at Manoa (UHM)',
        description: 'Outdoor Workplaces in front of Natural Science Building with shed and electricity',
        placeType: "public",
        imagePath: 'assets/images/diamond.png',
        location: "21.3003692300479 -157.81494475453513",
        lastUpdate: '11/15/22',
        ownerID: 'user-002',
        editorIDs: ['user-001'],
        visitorIDs: ['user-003', 'user-005']),
    PlacesData(
        id: 'places-002',
        name: 'University of Hawaii at Manoa (UHM)',
        description: 'Under Tree in front Campus Center',
        placeType: "community",
        imagePath: 'assets/images/diamond.png',
        location: "21.3003692300479,-157.81494475453513",       
        lastUpdate: '10/10/22',
        editorIDs: ['user-002'],
        visitorIDs: ['user-001', 'user-005']),
    PlacesData(
        id: 'places-003',
        name: 'University of Hawaii at Manoa (UHM)',
        description: 'In front of SOEST Building with shed',
        placeType: "public",
        imagePath: 'assets/images/diamond.png',
        location: "2211 ALA WAI BLVD 96815 Honolulu",
        lastUpdate: '8/10/22',
        editorIDs: ['user-004'],
        visitorIDs: ['user-005'],
        ownerID: 'user-003')
  ];
  

  void addPlace({
      required String name,
      required String description,
      required String location,
      required String placeType,
      required String imageFileName,
      //required String areaID,
      required String ownerID,
      required List<String> editorIDs,
      required List<String> visitorIDs}) {

        
      String id = 'places-${(_places.length + 1).toString().padLeft(3, '0')}';
      String imagePath = 'assets/images/$imageFileName';
      String lastUpdate = DateFormat.yMd().format(DateTime.now());

      PlacesData data = PlacesData(
        id: id,
        name: name,
        description: description,
        location: location,
        placeType: placeType,
        imagePath: imagePath,
        lastUpdate: lastUpdate,
        ownerID: ownerID,
        editorIDs: editorIDs,
        visitorIDs: visitorIDs);
      _places.add(data);
    }

    void updatePlace({
      required String id,
      required String name,
      required String description,
      required String placeType,
      required String imagePath,
      required String location,
      required String ownerID,
      required List<String> visitorIDs,
      required List<String> editorIDs,
    }) {
      // First remove the current PlacesData instance.
      _places.removeWhere((placeData) => placeData.id == id);
      // Now add the updated version
      String lastUpdate = DateFormat.yMd().format(DateTime.now());
      PlacesData data = PlacesData(
        id: id,
        name: name,
        description: description,
        placeType: placeType,
        imagePath: imagePath,
        location: location,
        lastUpdate: lastUpdate,
        ownerID: ownerID,
        editorIDs: editorIDs,
        visitorIDs: visitorIDs,
        
      );
      _places.add(data);
    }





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



List<String> getAssociatedUserIDs(String placeID) {
  PlacesData data = getPlace(placeID);
  List<String> associatedUserIDs = [...data.visitorIDs, ...data.editorIDs];
  if (data.ownerID != null) {
    associatedUserIDs.add(data.ownerID!);
  }
  return associatedUserIDs;
}

  bool _userIsAssociated(String placeID, String userID) {
    PlacesData data = getPlace(placeID);
    return ((data.ownerID == userID) ||
        (data.visitorIDs.contains(userID)) ||
        (data.editorIDs.contains(userID)));
  }

UserData? getOwner(String placeID) {
  PlacesData data = getPlace(placeID);
  UserDB userDB = ref.read(userDBProvider);

  // Check if ownerID is not null
  if (data.ownerID != null) {
    return userDB.getUser(data.ownerID!); // Use the non-nullable value
  } else {
    // Handle the case where ownerID is null
    print("This is a public or community place.");
    return null; // Return null or handle accordingly
  }
}

String getLocation(String placeID) {
  PlacesData data = getPlace(placeID);
  return data.location;
}

    List<UserData> getEditors(String placeID) {
      PlacesData data = getPlace(placeID);
      UserDB userDB = ref.read(userDBProvider);
      return userDB.getUsers(data.editorIDs);
    }

    List<UserData> getViewers(String placeID) {
      PlacesData data = getPlace(placeID);
      UserDB userDB = ref.read(userDBProvider);
      return userDB.getUsers(data.visitorIDs);
  }
}


/* 


  PlacesData getPlace(String placeID) {
    return _places.firstWhere((data) => data.id == placeID);
  }

  List<String> getPlaceIDs() {
    return _places.map((data) => data.id).toList();
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


final placesDBProvider = Provider<PlacesDB>((ref) {
  return PlacesDB(ref);
});

/// The singleton instance of a placeDB used by clients to access place data.
//PlacesDB placesDB = PlacesDB(); */