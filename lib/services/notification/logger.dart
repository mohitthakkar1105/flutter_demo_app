import 'package:firebase_messaging/firebase_messaging.dart';

enum FcmState { foreground, background, tap }

class FcmLogger {
  FcmLogger._();

  static void logMessage(RemoteMessage message, {required FcmState state}) {
    final label = switch (state) {
      FcmState.foreground => '🟢 FOREGROUND',
      FcmState.background => '🔴 BACKGROUND',
      FcmState.tap        => '👆 TAP',
    };
    _box(label, message.data,
        title: message.notification?.title,
        body: message.notification?.body);
  }

  static void logData(String label, Map<String, dynamic> data) {
    _box(label, data);
  }

  static void _box(String label, Map<String, dynamic> data,
      {String? title, String? body}) {
    print("╔══════════════════════════════════════╗");
    print("║  $label");
    print("╠══════════════════════════════════════╣");
    if (title != null) print("║  Title : $title");
    if (body != null)  print("║  Body  : $body");
    if (data.isEmpty) {
      print("║  data  : (empty)");
    } else {
      data.forEach((k, v) => print("║  $k : $v"));
    }
    print("╚══════════════════════════════════════╝");
  }
}