// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapScreen extends StatefulWidget {
//   final String title;
//   final double latitude;
//   final double longitude;

//   const MapScreen({
//     Key? key,
//     required this.title,
//     required this.latitude,
//     required this.longitude,
//   }) : super(key: key);

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final LatLng position = LatLng(widget.latitude, widget.longitude);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.title} Map View'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: position,
//           zoom: 15.0,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId('m1'),
//             position: position,
//           ),
//         },
//       ),
//     );
//   }
// }
