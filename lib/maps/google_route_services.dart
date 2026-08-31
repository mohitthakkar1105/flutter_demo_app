// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
//
// import '../constants/api_constants.dart';
//
// class RoutesService {
//   RoutesService._();
//
//   static final RoutesService instance = RoutesService._();
//
//   static const String _baseUrl =
//       'https://routes.googleapis.com/directions/v2:computeRoutes';
//
//   Future<List<LatLng>> getRoute({
//     required LatLng origin,
//     required LatLng destination,
//   }) async {
//     try {
//       final response = await http
//           .post(
//         Uri.parse(_baseUrl),
//         headers: {
//           "Content-Type": "application/json",
//           "X-Goog-Api-Key": 'AIzaSyBIG8R7Y12hEyN-WAP5MC_hk9X-IDmq4xQ',
//           "X-Goog-FieldMask":
//           "routes.polyline.encodedPolyline,routes.distanceMeters,routes.duration",
//         },
//         body: jsonEncode({
//           "origin": {
//             "location": {
//               "latLng": {
//                 "latitude": origin.latitude,
//                 "longitude": origin.longitude,
//               }
//             }
//           },
//           "destination": {
//             "location": {
//               "latLng": {
//                 "latitude": destination.latitude,
//                 "longitude": destination.longitude,
//               }
//             }
//           },
//           "travelMode": "DRIVE",
//           "computeAlternativeRoutes": false,
//           "polylineQuality": "HIGH_QUALITY",
//         }),
//       )
//           .timeout(const Duration(seconds: 20));
//
//       if (response.statusCode != 200) {
//         throw Exception(
//           "Routes API Error (${response.statusCode}) : ${response.body}",
//         );
//       }
//
//       final Map<String, dynamic> json = jsonDecode(response.body);
//
//       if (json["routes"] == null || (json["routes"] as List).isEmpty) {
//         throw Exception("No route found.");
//       }
//
//       final String encodedPolyline =
//       json["routes"][0]["polyline"]["encodedPolyline"];
//
//       return _decodePolyline(encodedPolyline);
//     } on TimeoutException {
//       throw Exception("Routes request timed out.");
//     } catch (e) {
//       debugPrint("RoutesService : $e");
//       rethrow;
//     }
//   }
//
//   //══════════════════════════════════════════════
//   // Decode Google Encoded Polyline
//   //══════════════════════════════════════════════
//
//   List<LatLng> _decodePolyline(String encoded) {
//     final List<LatLng> points = [];
//
//     int index = 0;
//     int lat = 0;
//     int lng = 0;
//
//     while (index < encoded.length) {
//       int shift = 0;
//       int result = 0;
//
//       while (true) {
//         final int b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//
//         if (b < 0x20) break;
//       }
//
//       final int deltaLat =
//       (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
//
//       lat += deltaLat;
//
//       shift = 0;
//       result = 0;
//
//       while (true) {
//         final int b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//
//         if (b < 0x20) break;
//       }
//
//       final int deltaLng =
//       (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
//
//       lng += deltaLng;
//
//       points.add(
//         LatLng(
//           lat / 1E5,
//           lng / 1E5,
//         ),
//       );
//     }
//
//     debugPrint("Decoded Polyline Points : ${points.length}");
//
//     return points;
//   }
// }