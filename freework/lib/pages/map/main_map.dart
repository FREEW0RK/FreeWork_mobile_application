import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  static const routeName = "/main_map";

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  GoogleMapController? _controller;
  final LatLng _initialPosition = const LatLng(37.7749, -122.4194); // Initial map position

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map Example'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14.0, // Adjust the initial zoom level as needed
        ),
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _controller = controller;
          });
        },
        markers: {
          // Add markers for specific places
          Marker(
            markerId: MarkerId('place1'),
            position: LatLng(37.7749, -122.4194), // Replace with specific place coordinates
            infoWindow: InfoWindow(title: 'Place 1'),
          ),
          Marker(
            markerId: MarkerId('place2'),
            position: LatLng(37.773972, -122.430991), // Replace with specific place coordinates
            infoWindow: InfoWindow(title: 'Place 2'),
          ),
          // Add more markers as needed
        },
        myLocationEnabled: true, // Show user's location
      ),
    );
  }
}