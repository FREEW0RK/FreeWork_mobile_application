import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MainMap extends StatefulWidget {
  const MainMap({Key? key}) : super(key: key);

  static const routeName = "/main_map";

  @override
  _MainMapState createState() => _MainMapState();
}




class _MainMapState extends State<MainMap> {
  GoogleMapController? mapController;
  late String _mapStyle;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  List<Marker> markers = [];


    //Camera positions
    final LatLng _initialPosition = const LatLng(21.300730704104364, -157.81481745653235);
    static final CameraPosition _Waikiki = CameraPosition(
    target: LatLng(21.322, -157.883),
    zoom: 14,
    );
    static final CameraPosition _UHmanoa = CameraPosition(
    target: LatLng(21.3, -157.823),
    tilt:60,
    zoom: 14,
    );


  @override
  void initState() {
    super.initState();
    addCustomIcon();
    rootBundle.loadString('assets/map_styles/map_style.json').then((string) {
      _mapStyle = string;
    });
    // Fetch places from Firestore and add markers
    retrievePlaces();
    // Move camera to the initial position
    moveCameraToInitialPosition();
  }


  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "/assets/images/diamond.png").then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }


  void retrievePlaces() async {
    // Fetch places from Firestore
    QuerySnapshot<Map<String, dynamic>> placesSnapshot = await FirebaseFirestore.instance.collection('places').get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> placeSnapshot in placesSnapshot.docs) {
      Map<String, dynamic> placeData = placeSnapshot.data()!;
      String id = placeSnapshot.id;
      String name = placeData['name'];
    // Access latitude and longitude directly from GeoPoint
      double latitude = placeData["location"].latitude;
      double longitude = placeData["location"].longitude;
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: name),
        // icon: markerIcon,
        ),
      );
    }


    // Update the state with the new markers
    if (mounted) {
      setState(() {});
    }
  }


  void moveCameraToInitialPosition() {
    if (mapController != null) {
      mapController?.animateCamera(CameraUpdate.newLatLngZoom(_initialPosition, 14.0));
    }
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('YOUR FREEWORK MAP'),
    ),

    // GOOGLE MAP UI
    body: GoogleMap(
      initialCameraPosition: _UHmanoa,
      onMapCreated: (GoogleMapController controller) {
        setState(() {
          mapController = controller;
          mapController?.setMapStyle(_mapStyle);
        }); 
      },
      markers: Set.from(markers),
      myLocationEnabled: true,
    ),




    floatingActionButton: Align(
      alignment: Alignment.bottomLeft,
      child: FloatingActionButton.extended(
      onPressed: _goToInitPos, 
      label: Text("My position"),
      icon: Icon(Icons.person_pin),
    ),
  ),
  );
}

Future<void> _goToInitPos() async {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(_UHmanoa));
}

}



/* 
class MainMap extends StatefulWidget {
  const MainMap({super.key});

  static const routeName = "/main_map";

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  GoogleMapController mapController;
  List<Marker> markers = [];

  final LatLng _initialPosition = const LatLng(21.300730704104364, -157.81481745653235); // Initial map position
  late String _mapStyle;

BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;



@override
void initState() {
  addCustomIcon();
  super.initState();

  rootBundle.loadString('assets/map_styles/map_style.json').then((string) {
    _mapStyle = string;
  });
}



void addCustomIcon() {
  BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), "/assets/images/diamond.png")
      .then(
    (icon) {
      setState(() {
        markerIcon = icon;
      });
    },
  );
}

 void _onMapTap(LatLng position) {
    // Handle the tapped location
    print('Tapped location: $position');

    // Use the position as needed, e.g., store in a variable or pass to another function
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YOUR FREEWORK MAP'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14.0, // Adjust the initial zoom level as needed
        ),
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            mapController = controller;
            mapController?.setMapStyle(_mapStyle);
          });
        },
        markers: {
          // Add markers for specific places
          const Marker(
            markerId: MarkerId('place1'),
            position: LatLng(21.298214862534557, -157.816458679196), // Replace with specific place coordinates
            infoWindow: InfoWindow(title: 'Public'),
            //icon: markerIcon,
          ),
          const Marker(
            markerId: MarkerId('place2'),
            position: LatLng(21.300079175774822, -157.8150063525567), // Replace with specific place coordinates
            infoWindow: InfoWindow(title: 'Community'),
          ),
          // Add more markers as needed
        },
        myLocationEnabled: true, // Show user's location
      ),
    );
  }
} */