import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'place.freezed.dart';
part 'place.g.dart';

/// Garden Document.
/// You must tell Firestore to use the 'id' field as the documentID
@freezed
class Place with _$Place {
  const factory Place({
    required String id,
    required String name,
    required String description,
    //@JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson,) required GeoPoint location,
    @GeoPointConverter() required GeoPoint location,
    required String placeType,
    required String imagePath,
    required String ownerID,
    //required String chapterID,
    required String lastUpdate,
    @Default([]) List<String> editorIDs,
    @Default([]) List<String> visitorIDs,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  factory Place.fromMap(Map<String, dynamic> json) {
    return Place(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: GeoPoint(
        (json['location']['latitude'] as num).toDouble(),
        (json['location']['longitude'] as num).toDouble(),
      ),
      placeType: json['placeType'] as String,
      imagePath: json['imagePath'] as String,
      lastUpdate: json['lastUpdate'] as String,
      ownerID: json['ownerID'] as String,
      editorIDs: (json['editorIDs'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      visitorIDs: (json['visitorIDs'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }

  // Test that the json file can be converted into entities.
  static Future<List<Place>> checkInitialData() async {
    String content = await rootBundle.loadString("assets/images/places.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => Place.fromMap(jsonData)).toList();
  }
}

GeoPoint _geoPointFromJson(Map<String, dynamic> json) =>
    GeoPointConverter().fromJson(json['location']);

Map<String, dynamic> _geoPointToJson(GeoPoint geoPoint) =>
    {'location': GeoPointConverter().toJson(geoPoint)};

/* class GeoPointConverter
    implements JsonConverter<GeoPoint, GeoPoint> {
  const GeoPointConverter();

  @override
  GeoPoint fromJson(GeoPoint geoPoint) {
    return geoPoint;
  }

  @override
  GeoPoint toJson(GeoPoint geoPoint) =>
      geoPoint;
} */

class GeoPointConverter implements JsonConverter<GeoPoint, GeoPoint> {
  const GeoPointConverter();

  @override
  GeoPoint fromJson(GeoPoint json) {
    return json;
  }

  @override
  GeoPoint toJson(GeoPoint object) {
    return object;
  }
}




   /* factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: GeoPoint(
        (json['location']['latitude'] as num).toDouble(),
        (json['location']['longitude'] as num).toDouble(),
      ),
      placeType: json['placeType'] as String,
      imagePath: json['imagePath'] as String,
      lastUpdate: json['lastUpdate'] as String,
      ownerID: json['ownerID'] as String,
      editorIDs: (json['editorIDs'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      visitorIDs: (json['visitorIDs'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    ); 
   } */
  

/*   static Future<List<Place>> checkInitialData() async {
  String content = await rootBundle.loadString("assets/images/places.json");
  List<dynamic> initialData = json.decode(content);
  List<Place> places = [];

  for (var jsonData in initialData) {
    if (kDebugMode) {
      print('Original JSON: $jsonData');
    }
    // Convert List<double> to GeoPoint
    GeoPoint location = GeoPoint(jsonData['location'][0], jsonData['location'][1]);
    // Create Place instance with GeoPoint
    Place place = Place.fromJson(jsonData.copyWith(location: location));
    if (kDebugMode) {
      print('Converted Place: $place');
    }
    places.add(place);
  }
  return places;
} */
















/* import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'place.freezed.dart';
part 'place.g.dart';

/// Garden Document.
/// You must tell Firestore to use the 'id' field as the documentID
@freezed
@JsonSerializable(explicitToJson: true)
class Place with _$Place {
  const factory Place({
    required String id,
    required String name,
    required String description,
    @JsonKey(fromJson: _geoPointFromJson, toJson: _geoPointToJson,) required GeoPoint location,
    //@GeoPointConverter() required GeoPoint location,
    required String placeType,
    required String imagePath,
    required String ownerID,
    //required String chapterID,
    required String lastUpdate,
    @Default([]) List<String> editorIDs,
    @Default([]) List<String> visitorIDs,
  }) = _Place;
   
  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);


 // Test that the json file can be converted into entities.
  static Future<List<Place>> checkInitialData() async {
    String content =
        await rootBundle.loadString("assets/images/places.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => Place.fromJson(jsonData)).toList();
  } 

}
 GeoPoint _geoPointFromJson(Map<String, dynamic> json) =>
      GeoPointConverter().fromJson(json['location']);

 Map<String, dynamic> _geoPointToJson(GeoPoint geoPoint) =>
      {'location': GeoPointConverter().toJson(geoPoint)};


class GeoPointConverter implements JsonConverter<GeoPoint, Map<String, dynamic>> {
  const GeoPointConverter();

  @override
  GeoPoint fromJson(Map<String, dynamic> json) {
    return GeoPoint(
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson(GeoPoint object) {
    return {
      'latitude': object.latitude,
      'longitude': object.longitude,
    };
  } 
}




   /* factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: GeoPoint(
        (json['location']['latitude'] as num).toDouble(),
        (json['location']['longitude'] as num).toDouble(),
      ),
      placeType: json['placeType'] as String,
      imagePath: json['imagePath'] as String,
      lastUpdate: json['lastUpdate'] as String,
      ownerID: json['ownerID'] as String,
      editorIDs: (json['editorIDs'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      visitorIDs: (json['visitorIDs'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    ); 
   } */
  

/*   static Future<List<Place>> checkInitialData() async {
  String content = await rootBundle.loadString("assets/images/places.json");
  List<dynamic> initialData = json.decode(content);
  List<Place> places = [];

  for (var jsonData in initialData) {
    if (kDebugMode) {
      print('Original JSON: $jsonData');
    }
    // Convert List<double> to GeoPoint
    GeoPoint location = GeoPoint(jsonData['location'][0], jsonData['location'][1]);
    // Create Place instance with GeoPoint
    Place place = Place.fromJson(jsonData.copyWith(location: location));
    if (kDebugMode) {
      print('Converted Place: $place');
    }
    places.add(place);
  }
  return places;
} */ */