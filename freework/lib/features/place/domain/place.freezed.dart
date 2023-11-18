// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return _Place.fromJson(json);
}

/// @nodoc
mixin _$Place {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get placeType => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  String get ownerID =>
      throw _privateConstructorUsedError; //required String chapterID,
  String get lastUpdate => throw _privateConstructorUsedError;
  List<String> get editorIDs => throw _privateConstructorUsedError;
  List<String> get visitorIDs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaceCopyWith<Place> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceCopyWith<$Res> {
  factory $PlaceCopyWith(Place value, $Res Function(Place) then) =
      _$PlaceCopyWithImpl<$Res, Place>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String location,
      String placeType,
      String imagePath,
      String ownerID,
      String lastUpdate,
      List<String> editorIDs,
      List<String> visitorIDs});
}

/// @nodoc
class _$PlaceCopyWithImpl<$Res, $Val extends Place>
    implements $PlaceCopyWith<$Res> {
  _$PlaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? placeType = null,
    Object? imagePath = null,
    Object? ownerID = null,
    Object? lastUpdate = null,
    Object? editorIDs = null,
    Object? visitorIDs = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      placeType: null == placeType
          ? _value.placeType
          : placeType // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      ownerID: null == ownerID
          ? _value.ownerID
          : ownerID // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as String,
      editorIDs: null == editorIDs
          ? _value.editorIDs
          : editorIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      visitorIDs: null == visitorIDs
          ? _value.visitorIDs
          : visitorIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlaceImplCopyWith<$Res> implements $PlaceCopyWith<$Res> {
  factory _$$PlaceImplCopyWith(
          _$PlaceImpl value, $Res Function(_$PlaceImpl) then) =
      __$$PlaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String location,
      String placeType,
      String imagePath,
      String ownerID,
      String lastUpdate,
      List<String> editorIDs,
      List<String> visitorIDs});
}

/// @nodoc
class __$$PlaceImplCopyWithImpl<$Res>
    extends _$PlaceCopyWithImpl<$Res, _$PlaceImpl>
    implements _$$PlaceImplCopyWith<$Res> {
  __$$PlaceImplCopyWithImpl(
      _$PlaceImpl _value, $Res Function(_$PlaceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? placeType = null,
    Object? imagePath = null,
    Object? ownerID = null,
    Object? lastUpdate = null,
    Object? editorIDs = null,
    Object? visitorIDs = null,
  }) {
    return _then(_$PlaceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      placeType: null == placeType
          ? _value.placeType
          : placeType // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      ownerID: null == ownerID
          ? _value.ownerID
          : ownerID // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as String,
      editorIDs: null == editorIDs
          ? _value._editorIDs
          : editorIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      visitorIDs: null == visitorIDs
          ? _value._visitorIDs
          : visitorIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaceImpl implements _Place {
  const _$PlaceImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.location,
      required this.placeType,
      required this.imagePath,
      required this.ownerID,
      required this.lastUpdate,
      final List<String> editorIDs = const [],
      final List<String> visitorIDs = const []})
      : _editorIDs = editorIDs,
        _visitorIDs = visitorIDs;

  factory _$PlaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaceImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String location;
  @override
  final String placeType;
  @override
  final String imagePath;
  @override
  final String ownerID;
//required String chapterID,
  @override
  final String lastUpdate;
  final List<String> _editorIDs;
  @override
  @JsonKey()
  List<String> get editorIDs {
    if (_editorIDs is EqualUnmodifiableListView) return _editorIDs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_editorIDs);
  }

  final List<String> _visitorIDs;
  @override
  @JsonKey()
  List<String> get visitorIDs {
    if (_visitorIDs is EqualUnmodifiableListView) return _visitorIDs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visitorIDs);
  }

  @override
  String toString() {
    return 'Place(id: $id, name: $name, description: $description, location: $location, placeType: $placeType, imagePath: $imagePath, ownerID: $ownerID, lastUpdate: $lastUpdate, editorIDs: $editorIDs, visitorIDs: $visitorIDs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.placeType, placeType) ||
                other.placeType == placeType) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.ownerID, ownerID) || other.ownerID == ownerID) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            const DeepCollectionEquality()
                .equals(other._editorIDs, _editorIDs) &&
            const DeepCollectionEquality()
                .equals(other._visitorIDs, _visitorIDs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      location,
      placeType,
      imagePath,
      ownerID,
      lastUpdate,
      const DeepCollectionEquality().hash(_editorIDs),
      const DeepCollectionEquality().hash(_visitorIDs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaceImplCopyWith<_$PlaceImpl> get copyWith =>
      __$$PlaceImplCopyWithImpl<_$PlaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaceImplToJson(
      this,
    );
  }
}

abstract class _Place implements Place {
  const factory _Place(
      {required final String id,
      required final String name,
      required final String description,
      required final String location,
      required final String placeType,
      required final String imagePath,
      required final String ownerID,
      required final String lastUpdate,
      final List<String> editorIDs,
      final List<String> visitorIDs}) = _$PlaceImpl;

  factory _Place.fromJson(Map<String, dynamic> json) = _$PlaceImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get location;
  @override
  String get placeType;
  @override
  String get imagePath;
  @override
  String get ownerID;
  @override //required String chapterID,
  String get lastUpdate;
  @override
  List<String> get editorIDs;
  @override
  List<String> get visitorIDs;
  @override
  @JsonKey(ignore: true)
  _$$PlaceImplCopyWith<_$PlaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
