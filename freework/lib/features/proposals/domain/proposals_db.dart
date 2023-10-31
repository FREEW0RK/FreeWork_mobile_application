import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// The data associated with users.
class PropsData {
  PropsData({
    required this.id,
    required this.icon,
    required this.title,
    required this.body,
    required this.date,
    required this.userID,
    this.areaID,
    this.placesID,
  });

  String id;
  IconData icon;
  String title;
  String body;
  String date;
  String userID;
  String? areaID;
  String? placesID;
}

/// Provides access to and operations on all defined users.
class PropsDB {
  PropsDB(this.ref);
  final ProviderRef<PropsDB> ref;
  final List<PropsData> _props = [
    PropsData(
        id: 'props-001',
        userID: 'user-001',
        areaID: 'chapter-001',
        icon: Icons.severe_cold,
        title: 'Frost Alert',
        body: 'Predicted overnight low of 37\u00B0 for 11/15/22',
        date: '11/15/22'),
    PropsData(
        id: 'props-002',
        userID: 'user-001',
        placesID: 'garden-001',
        icon: Icons.image_search,
        title: 'Reply to: "Something is eating these bean sprouts...',
        body: '... Looks like it could be a rabbit or...',
        date: '11/10/22'),
    PropsData(
        id: 'props-003',
        userID: 'user-001',
        areaID: 'chapter-001',
        icon: Icons.group_add,
        title: 'New Chapter Members',
        body: '@AsaD, @CyTheGuy',
        date: '11/20/22'),
    PropsData(
        id: 'props-004',
        userID: 'user-001',
        areaID: 'chapter-001',
        icon: Icons.water_drop,
        title: 'New seed(s) available',
        body: "Lettuce (Flashy Trout's Back), Bean (Tanya's Pink Pod), Squash (Zepplin Delicata)",
        date: '11/25/22'),
    PropsData(
        id: 'props-005',
        userID: 'user-001',
        placesID: 'garden-002',
        icon: Icons.yard_outlined,
        title: 'First Harvest expected',
        body: "Pepper (Bridge to Paris), Pumpkin (Winter Luxury)",
        date: '11/25/22'),
    PropsData(
        id: 'props-006',
        userID: 'user-001',
        areaID: 'chapter-001',
        icon: Icons.pest_control,
        title: 'Pest Alert: Aphids',
        body: "10 gardens with Aphid pest observations this week",
        date: '11/30/22'),
  ];

  List<String> getPropsIDs() {
    return _props.map((data) => data.id).toList();
  }

  PropsData getProps(propsID) {
    return _props.firstWhere((data) => data.id == propsID);
  }

  List<String> getAssociatedPropsIDs(String userID) {
    return getPropsIDs()
        .where((propsID) => getProps(propsID).userID == userID)
        .toList();
  }
}

/// The singleton instance providing access to all user data for clients.
//PropsDB propsDB = PropsDB();
