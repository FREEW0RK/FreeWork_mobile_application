import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User Document.
/// You must tell Firestore to use the 'id' field as the documentID
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String username,
    String? imagePath,
    required String initials,
  }) = _User;

  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Test that the json file can be converted into entities.
  static Future<List<User>> checkInitialData() async {
    String content =
        await rootBundle.loadString("assets\initialData/users.json");
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => User.fromJson(jsonData)).toList();
  }
}


/* 
/// The data associated with users.
class UserData {
  UserData(
      {required this.id\
      required this.name,
      required this.location,
      required this.email,
      required this.username,
      this.imagePath,
      required this.initials});

  String id;
  String name;
  String email;
  List location;
  String username;
  String? imagePath;
  String initials;
}

/// Provides access to and operations on all defined users.
class UserDB {
  // create UserDB in ref (constructor)
  UserDB(this.ref);
  // Provider

  final ProviderRef<UserDB> ref;
  final List<UserData> _users = [
   UserData(
    id: 'user-001',
    name: 'John Smith',
    username: '@jsmith',
    location: [21.300127557914898, -157.81483315187523],
    email: 'john.smith@example.com',
    imagePath: 'assets/images/freeworklogoearthgrinsgesicht.jpg',
    initials: 'JS'),
UserData(
    id: 'user-002',
    name: 'Mary Johnson',
    username: '@maryj',
    location: [21.300127557914898, -157.8148331518752555],
    email: 'mary.johnson@example.com',
    initials: 'MJ'),
UserData(
    id: 'user-003',
    name: 'David Brown',
    username: '@dbrown',
    location: [21.300127557914898, -157.81483315155523],
    email: 'david.brown@example.com',
    initials: 'DB'),
UserData(
    id: 'user-004',
    name: 'Sarah Williams',
    username: '@sarahw',
    location: [21.300127557914898, -157.8148331554487523],
    email: 'sarah.williams@example.com',
    initials: 'SW'),
UserData(
    id: 'user-005',
    name: 'Christoph Haring',
    username: '@CHaring',
    location: [21.300127557914898, -157.6000560453],
    email: 'CHaring@hawaii.edu',
    imagePath: 'assets/images/freeworklogoearthgrinsgesicht.jpg',
    initials: 'CH')

  ];

  UserData getUser(String userID) {
    return _users.firstWhere((userData) => userData.id == userID);
  }

  bool areUserNames(List<String> userNames) {
    List<String> allUserNames =
        _users.map((userData) => userData.username).toList();
    return userNames.every((userName) => allUserNames.contains(userName));
  }


  String getUserID(String emailOrUsername) {
    return (emailOrUsername.startsWith('@'))
        ? _users
            .firstWhere((userData) => userData.username == emailOrUsername)
            .id
        : _users.firstWhere((userData) => userData.email == emailOrUsername).id;
  }


  bool isUserEmail(String email) {
    List<String> emails = _users.map((userData) => userData.email).toList();
    return emails.contains(email);
  }

  List<UserData> getUsers(List<String> userIDs) {
    return _users.where((userData) => userIDs.contains(userData.id)).toList();
  }

  List<String> getAllEmails() {
    return _users.map((userData) => userData.email).toList();
  }

  	
  List<dynamic> getUserLocation(String userID) {
  final userData = _users.firstWhere((userData) => userData.id == userID);
  return userData.location;
}

}



/* 
  // Return the userIDs of users who are in the same Chapter(s) as [userID].
  // First, get all of the chapterIDs that this [userID] is associated with.
  // Then build the set of all userIDs associated with the chapterIDs.
  List<String> getAssociatedUserIDs(String userID) {
    List<String> chapterIDs = chapterDB.getAssociatedChapterIDs(userID);
    Set<String> userIDs = {};
    for (var chapterID in chapterIDs) {
      userIDs.addAll(chapterDB.getAssociatedUserIDs(chapterID));
    }
    return userIDs.toList();
  }
 */



/* /// The singleton instance providing access to all user data for clients.
UserDB userDB = UserDB();

/// The currently logged in user.
String currentUserID = 'user-005';
 */ */