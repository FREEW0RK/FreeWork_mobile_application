import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    required String location,
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
        await rootBundle.loadString("initialData/places.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => Place.fromJson(jsonData)).toList();
  }
}
