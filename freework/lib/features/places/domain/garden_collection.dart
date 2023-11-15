import 'package:freework/features/places/data/Place.dart';

import 'place.dart';

/// Encapsulates operations on the list of [Place] returned from Firestore.

class PlaceCollection {
  PlaceCollection(places) : _places = places;

  final List<Place> _places;

  Place getPlace(String placeID) {
  return _places.firstWhere((data) => data.id == placeID);
  }

  int size() {
    return _places.length;
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
  /*   if (areaID != null) {
      return getPlaceIDs()
          .where((placeID) => getPlace(placeID).areaID == areaID)
          .toList();
    } */
    return [];
  }



  List<String> getAssociatedUserIDs(placeID) {
    Place data = getPlace(placeID);
    return [data.ownerID, ...data.viewerIDs, ...data.editorIDs];
  }

  /* List<String> getAssociatedUserIDs(String placeID) {
    Place data = getPlace(placeID);
    List<String> associatedUserIDs = [...data.visitorIDs, ...data.editorIDs];
    if (data.ownerID != null) {
      associatedUserIDs.add(data.ownerID!);
    }
    return associatedUserIDs;
  } */

  bool _userIsAssociated(String placeID, String userID) {
    PlacesData data = getPlace(placeID);
    return ((data.ownerID == userID) ||
        (data.visitorIDs.contains(userID)) ||
        (data.editorIDs.contains(userID)));
  }

  
  List<Place> getAssociatedPlaces({String? userID//, String? chapterID
  }) {
    if (userID != null) {
      return _Places
          .where((Place) => _userIsAssociated(Place.id, userID))
          .toList();
    }
   /*  if (chapterID != null) {
      return _Places.where((Place) => Place.chapterID == chapterID).toList();
    } */
    return [];
  }




  User? getOwner(String placeID) {
  PlacesData data = getPlace(placeID);
  User user = ref.read(userProvider);

  // Check if ownerID is not null
  if (data.ownerID != null) {
    return user.getUser(data.ownerID!); // Use the non-nullable value
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

List<User> getEditors(String placeID) {
  PlacesData data = getPlace(placeID);
  User user = ref.read(userProvider);
  return user.getUsers(data.editorIDs);
}

List<User> getViewers(String placeID) {
  PlacesData data = getPlace(placeID);
  User user = ref.read(userProvider);
  return user.getUsers(data.visitorIDs);
}
}

