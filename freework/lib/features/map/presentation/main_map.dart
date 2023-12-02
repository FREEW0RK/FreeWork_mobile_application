import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart' show rootBundle;




class MainMap extends StatefulWidget {
  const MainMap({super.key});

  static const routeName = "/main_map";

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  GoogleMapController? _controller;
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
            _controller = controller;
            _controller?.setMapStyle(_mapStyle);
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
}