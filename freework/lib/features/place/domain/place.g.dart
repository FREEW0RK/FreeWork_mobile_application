// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaceImpl _$$PlaceImplFromJson(Map<String, dynamic> json) => _$PlaceImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      placeType: json['placeType'] as String,
      imagePath: json['imagePath'] as String,
      ownerID: json['ownerID'] as String,
      lastUpdate: json['lastUpdate'] as String,
      editorIDs: (json['editorIDs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      visitorIDs: (json['visitorIDs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PlaceImplToJson(_$PlaceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'placeType': instance.placeType,
      'imagePath': instance.imagePath,
      'ownerID': instance.ownerID,
      'lastUpdate': instance.lastUpdate,
      'editorIDs': instance.editorIDs,
      'visitorIDs': instance.visitorIDs,
    };
