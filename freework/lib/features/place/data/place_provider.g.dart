// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$placeDatabaseHash() => r'498334ceadcd35d279317e08bac91b07624c9386';

/// See also [placeDatabase].
@ProviderFor(placeDatabase)
final placeDatabaseProvider = AutoDisposeProvider<PlaceDatabase>.internal(
  placeDatabase,
  name: r'placeDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$placeDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlaceDatabaseRef = AutoDisposeProviderRef<PlaceDatabase>;
String _$placeHash() => r'964ac055f3a2550e50cc6fd2ca73be1f3143467c';

/// See also [place].
@ProviderFor(place)
final placeProvider = AutoDisposeStreamProvider<List<Place>>.internal(
  place,
  name: r'placeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$placeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlaceRef = AutoDisposeStreamProviderRef<List<Place>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
