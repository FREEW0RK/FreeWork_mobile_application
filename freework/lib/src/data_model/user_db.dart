
/// The data associated with users.
class UserData {
  UserData(
      {required this.id,
      required this.name,
      required this.location,
      required this.email,
      required this.username,
      this.imagePath,
      required this.initials});

  String id;
  String name;
  String email;
  String location;
  String username;
  String? imagePath;
  String initials;
}

/// Provides access to and operations on all defined users.
class UserDB {
  final List<UserData> _users = [
   UserData(
    id: 'user-001',
    name: 'John Smith',
    username: '@jsmith',
    location: "21.300127557914898, -157.81483315187523",
    email: 'john.smith@example.com',
    imagePath: 'assets/images/user-001.jpg',
    initials: 'JS'),
UserData(
    id: 'user-002',
    name: 'Mary Johnson',
    username: '@maryj',
    location: "21.300127557914898, -157.81483315187523",
    email: 'mary.johnson@example.com',
    initials: 'MJ'),
UserData(
    id: 'user-003',
    name: 'David Brown',
    username: '@dbrown',
    location: "21.300127557914898, -157.81483315187523",
    email: 'david.brown@example.com',
    initials: 'DB'),
UserData(
    id: 'user-004',
    name: 'Sarah Williams',
    username: '@sarahw',
    location: "21.300127557914898, -157.81483315187523",
    email: 'sarah.williams@example.com',
    initials: 'SW'),
UserData(
    id: 'user-005',
    name: 'Christoph Haring',
    username: '@CHaring',
    location: "21.300127557914898, -157.81483315187523",
    email: 'CHaring@hawaii.edu',
    imagePath: 'assets/images/user/freeworklogoearthgrinsgesicht.jpg',
    initials: 'CH')

  ];

  UserData getUser(String userID) {
    return _users.firstWhere((userData) => userData.id == userID);
  }

  List<UserData> getUsers(List<String> userIDs) {
    return _users.where((userData) => userIDs.contains(userData.id)).toList();
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

}

/// The singleton instance providing access to all user data for clients.
UserDB userDB = UserDB();

/// The currently logged in user.
String currentUserID = 'user-005';
