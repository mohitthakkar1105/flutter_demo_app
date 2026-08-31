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
//     zoom: 16,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//
//     final provider = context.read<MapProvider>();
//
//     return Scaffold(
//       body: Stack(
//         children: [
//
//           GoogleMap(
//             initialCameraPosition: initialCamera,
//             onCameraMove: provider.onCameraMove,
//             onCameraIdle: provider.onCameraIdle,
//
//           ),
//
//           IgnorePointer(
//             child: Center(
//               child: Icon(
//                 Icons.location_pin,
//                 size: 50,
//                 color: Colors.red,
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }