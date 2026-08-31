// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../services/location_service.dart';
//
// class MapProvider extends ChangeNotifier {
//
//   LatLng _selectedLocation = const LatLng(20.5937, 78.9629);
//
//   LatLng get selectedLocation => _selectedLocation;
//
//   /// User is dragging the map
//   void onCameraMove(CameraPosition position) {
//     _selectedLocation = position.target;
//   }
//
//   /// User stopped dragging
//   Future<void> onCameraIdle() async {
//     try {
//       debugPrint("Lat : ${_selectedLocation.latitude}");
//       debugPrint("Lng : ${_selectedLocation.longitude}");
//
//       final placemark =
//       await LocationService.instance.getPlacemarkFromLatLng(
//         latitude: _selectedLocation.latitude,
//         longitude: _selectedLocation.longitude,
//       );
//
//       debugPrint("Name : ${placemark.name}");
//       debugPrint("Street : ${placemark.street}");
//       debugPrint("Locality : ${placemark.locality}");
//       debugPrint("State : ${placemark.administrativeArea}");
//       debugPrint("Country : ${placemark.country}");
//     } catch (e) {
//       debugPrint("MapProvider : $e");
//     }
//   }
// }