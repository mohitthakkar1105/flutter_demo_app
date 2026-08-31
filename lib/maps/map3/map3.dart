// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
//
// import 'map_provider.dart';
//
// class MapScreen extends StatelessWidget {
//   const MapScreen({super.key});
//
//   static const CameraPosition initialCamera = CameraPosition(
//     target: LatLng(20.5937, 78.9629),
//     zoom: 5,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Consumer<MapProvider>(
//           builder: (context, mapProvider, child) {
//             return GoogleMap(
//               initialCameraPosition: initialCamera,
//               onMapCreated: mapProvider.onMapCreated,
//               markers: mapProvider.markers,
//               polylines: mapProvider.polylines,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }