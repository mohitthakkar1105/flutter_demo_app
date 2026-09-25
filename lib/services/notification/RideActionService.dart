import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class RideActionService {
  static const MethodChannel _channel =
  MethodChannel('ride_action');

  static void listen({
    required Future<void> Function(String action) onAction,
  }) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'rideAccepted') {
        final action = call.arguments as String?;

        if (action != null) {
          debugPrint('🔥 RIDE ACTION: $action');

          await onAction(action);
        }
      }
    });
  }
}