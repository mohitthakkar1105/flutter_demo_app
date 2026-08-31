//
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapService {
//   MapService._();
//
//   static final MapService instance = MapService._();
//
//   GoogleMapController? _controller;
//
//   /// Set Google Map Controller
//   void setController(GoogleMapController controller) {
//     _controller = controller;
//   }
//
//   /// Get Controller
//   GoogleMapController? get controller => _controller;
//
//   /// Move Camera Instantly
//   Future<void> moveCamera({
//     required LatLng target,
//     double zoom = 16,
//   }) async {
//     if (_controller == null) return;
//
//     await _controller!.moveCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: target,
//           zoom: zoom,
//         ),
//       ),
//     );
//   }
//
//   /// Animate Camera
//   Future<void> animateCamera({
//     required LatLng target,
//     double zoom = 16,
//   }) async {
//     if (_controller == null) return;
//
//     await _controller!.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: target,
//           zoom: zoom,
//         ),
//       ),
//     );
//   }
//
//   /// Zoom In
//   Future<void> zoomIn() async {
//     if (_controller == null) return;
//
//     await _controller!.animateCamera(
//       CameraUpdate.zoomIn(),
//     );
//   }
//
//   /// Zoom Out
//   Future<void> zoomOut() async {
//     if (_controller == null) return;
//
//     await _controller!.animateCamera(
//       CameraUpdate.zoomOut(),
//     );
//   }
//
//   /// Dispose
//   void dispose() {
//     _controller?.dispose();
//     _controller = null;
//   }
// }