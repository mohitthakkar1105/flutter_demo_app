// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../services/google_routes_Services.dart';
// import '../services/location_service.dart';
// import '../services/map_service.dart';
//
// class MapProvider extends ChangeNotifier {
//
//   bool _isMapReady = false;
//
//   bool get isMapReady => _isMapReady;
//
//   Set<Polyline> _polylines = {};
//
//   Set<Polyline> get polylines => _polylines;
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
//     try {
//
//       final position =
//       await LocationService.instance.getCurrentLocation();
//
//       final current = LatLng(
//         position.latitude,
//         position.longitude,
//       );
//
//       await MapService.instance.animateCamera(
//         target: current,
//         zoom: 16,
//       );
//
//       addCurrentLocationMarker(
//         position: current,
//       );
//
//       await drawRoute(
//         origin: current,
//         destination: LatLng(
//           current.latitude + 0.02,
//           current.longitude + 0.02,
//         ),
//       );
//
//     } catch (e) {
//
//       debugPrint(e.toString());
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
//   void drawPolyline({
//     required List<LatLng> points,
//   }) {
//
//     _polylines.clear();
//
//     _polylines.add(
//       Polyline(
//         polylineId: const PolylineId("route"),
//
//         points: points,
//
//         color: Colors.blue,
//
//         width: 6,
//
//         geodesic: true,
//       ),
//     );
//
//     notifyListeners();
//   }
//
//
//   Future<void> drawRoute({
//     required LatLng origin,
//     required LatLng destination,
//   }) async {
//
//     try {
//
//       final points =
//       await RoutesService.instance.getRoute(
//         origin: origin,
//         destination: destination,
//       );
//
//       drawPolyline(
//         points: points,
//       );
//
//     } catch (e) {
//
//       debugPrint(e.toString());
//
//     }
//
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
//
//
// // multiple dikhane ke liey
// //_polylines.clear();
// //
// // _polylines.add(driverToPickupPolyline);
// //
// // _polylines.add(pickupToDestinationPolyline);