// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../services/location_service.dart';
// import '../services/map_service.dart';
//
// class MapProvider extends ChangeNotifier {
//
//   bool _isMapReady = false;
//
//   bool get isMapReady => _isMapReady;
//
//   Set<Marker> _markers = {};
//
//   Set<Marker> get markers => _markers;
//
//   BitmapDescriptor? _currentLocationIcon;
//
//   Future<void> loadMarkerIcons() async {
//     _currentLocationIcon = await BitmapDescriptor.asset(
//       const ImageConfiguration(
//         size: Size(48, 48),
//       ),
//       "assets/images/car_marker.png",
//     );
//   }
//
//   /// Called when Google Map is created
//   Future<void> onMapCreated(
//       GoogleMapController controller,
//       ) async {
//
//     MapService.instance.setController(controller);
//
//     await loadMarkerIcons();
//
//     await moveToCurrentLocation();
//   }
//
//   /// Move camera to user's current location
//   Future<void> moveToCurrentLocation() async {
//
//     try {
//
//       final position =
//       await LocationService.instance.getCurrentLocation();
//
//       final currentLatLng = LatLng(
//         position.latitude,
//         position.longitude,
//       );
//
//       await MapService.instance.animateCamera(
//         target: LatLng(
//           position.latitude,
//           position.longitude,
//         ),
//         zoom: 17,
//       );
//
//
//       addCurrentLocationMarker(
//         position: currentLatLng,
//       );
//
//     } catch (e) {
//
//       debugPrint("MapProvider : $e");
//
//     }
//   }
//
//   void addCurrentLocationMarker({
//     required LatLng position,
//   }) {
//
//     _markers.clear();
//
//     _markers.add(
//       Marker(
//         markerId: const MarkerId("current_location"),
//         position: position,
//         infoWindow: const InfoWindow(
//           title: "Current Location",
//         ),
//         icon: _currentLocationIcon ?? BitmapDescriptor.defaultMarkerWithHue(
//           BitmapDescriptor.hueGreen,
//         ),
//       ),
//     );
//
//     notifyListeners();
//   }
//
//   @override
//   void dispose() {
//
//     MapService.instance.dispose();
//
//     super.dispose();
//   }
// }