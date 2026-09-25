import 'package:flutter/services.dart';

class OverlayPermissionService {
  static const MethodChannel _channel =
  MethodChannel('overlay_permission');

  static Future<void> openSettings() async {
    await _channel.invokeMethod('openOverlaySettings');
  }

  static Future<void> startRideOverlay() async {
    await _channel.invokeMethod('startRideOverlay');
  }

}