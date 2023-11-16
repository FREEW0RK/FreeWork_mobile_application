import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/place_provider.dart';
import '../domain/place.dart';

part 'edit_place_controller.g.dart';

// The design of this controller is modeled on:
// https://codewithandrea.com/articles/flutter-navigate-without-context-gorouter-riverpod/
// https://codewithandrea.com/articles/async-notifier-mounted-riverpod/
// I am not in love with the "mounted" shenanigans. Sigh.
@riverpod
class EditplaceController extends _$EditplaceController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
    state = const AsyncData(null);
  }

  // Invoked to add a new place or edit an existing one.
  Future<void> updateplace({
    required Place place,
    required VoidCallback onSuccess,
  }) async {
    state = const AsyncLoading();
    placeDatabase placeDatabase = ref.watch(placeDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => placeDatabase.setplace(place));
    if (mounted) {
      state = newState;
    }
    // Weird. Can't use "if (state.hasValue)" below.
    if (!state.hasError) {
      onSuccess();
    }
  }

  Future<void> deleteplace({
    required Place place,
    required VoidCallback onSuccess,
  }) async {
    state = const AsyncLoading();
    placeDatabase placeDatabase = ref.watch(placeDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => placeDatabase.deleteplace(place));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }
}
