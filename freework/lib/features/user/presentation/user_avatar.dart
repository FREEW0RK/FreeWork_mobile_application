import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/user..dart';
import 'package:freework/features/user/data/user_providers.dart';



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../agc_error.dart';
import '../../agc_loading.dart';
import '../../all_data_provider.dart';
import '../domain/user.dart';
import '../domain/user_collection.dart';

/// Builds a [CircleAvatar] with either an image if available or initials, plus a label.
class UserAvatar extends ConsumerWidget {
  const UserAvatar({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(users: allData.users),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build({required List<User> users}) {
    UserCollection userCollection = UserCollection(users);
    User user = userCollection.getUser(userID);
    return (user.imagePath != null)
        ? CircleAvatar(
            backgroundImage: AssetImage(user.imagePath!),
          )
        : CircleAvatar(
            child: Text(user.initials),
          );
  }
}



/* /// Returns a CircleAvatar with either an image if available or initials, plus a label.
class UserAvatar extends ConsumerWidget {
  const UserAvatar({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserDB userDB = ref.watch(userDBProvider);
    UserData data = userDB.getUser(userID);
    bool hasImagePath = data.imagePath != null;
    return
      (hasImagePath) ?
      CircleAvatar(
        backgroundImage: AssetImage(data.imagePath!),
      ) :
      CircleAvatar(
        child: Text(data.initials),
      );
  }
}
 */
