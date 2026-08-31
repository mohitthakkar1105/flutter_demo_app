import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../firebase_options.dart';
import '../../firebase_options.dart';
import 'app_notification_handler.dart';

// ══════════════════════════════════════════════════════════
// NOTIFICATION SERVICE — 100% REUSABLE
// Har project mein same rahega — kuch change mat karo
// Sirf AppNotificationHandler mein apna logic likho
// ══════════════════════════════════════════════════════════

// ✅ CLASS KE BAHAR — TOP LEVEL
@pragma('vm:entry-point')
Future<void> _onBackground(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("🔥 _onBackground CALLED");
  print("DATA => ${message.data}");
  print("NOTIFICATION => ${message.notification}");
  await AppNotificationHandler.onBackground(message);
}

@pragma('vm:entry-point')
class NotificationService {
  NotificationService._();

  static bool _initialized = false;
  static const String _pendingPrefix = 'notif_pending_';

  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    FirebaseMessaging.onBackgroundMessage(_onBackground);

    await AppNotificationHandler.initLocal();

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

    await _saveToken();
    _listenTokenRefresh();

    FirebaseMessaging.onMessage.listen(AppNotificationHandler.onForeground);
    FirebaseMessaging.onMessageOpenedApp.listen(
      AppNotificationHandler.onBackground_tap,
    );

    await _handleKilledState();
  }

  //═══════════════════════════════════════════════
  // KILLED STATE
  //═══════════════════════════════════════════════

  static Future<void> _handleKilledState() async {
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial == null) return;

    // Poora data save karo as-is
    final prefs = await SharedPreferences.getInstance();
    for (final entry in initial.data.entries) {
      await prefs.setString(
        '$_pendingPrefix${entry.key}',
        entry.value.toString(),
      );
    }

    print("💾 Killed Notification Saved => ${initial.data}");
  }

  // SplashScreen se call karo — navigate ke baad
  static Future<void> consumePendingTap() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs
          .getKeys()
          .where((k) => k.startsWith(_pendingPrefix))
          .toList();

      if (allKeys.isEmpty) return;

      // Data reconstruct karo
      final Map<String, dynamic> data = {};
      for (final key in allKeys) {
        data[key.replaceFirst(_pendingPrefix, '')] = prefs.getString(key) ?? "";
      }

      // Clear karo pehle
      for (final key in allKeys) {
        await prefs.remove(key);
      }

      print("📬 Consuming Killed Tap => $data");

      await AppNotificationHandler.onKilledTap(data);
    } catch (e) {
      print("❌ consumePendingTap Error: $e");
    }
  }

  //═══════════════════════════════════════════════
  // TOKEN
  //═══════════════════════════════════════════════

  static Future<void> _saveToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('fcm_token', token);
        print('🔥 FCM TOKEN => $token');
      }
      final apns = await FirebaseMessaging.instance.getAPNSToken();
      print("🍎 APNS TOKEN => $apns");
    } catch (e) {
      print("❌ FCM Token Error: $e");
    }
  }

  static void _listenTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final oldToken = prefs.getString('fcm_token');
        if (oldToken != newToken) {
          await prefs.setString('fcm_token', newToken);
          print("🔄 FCM Token Refreshed: $newToken");
          // TODO: backend ko bhejo
        }
      } catch (e) {
        print("❌ Token Refresh Error: $e");
      }
    });
  }

  //═══════════════════════════════════════════════
  // BACKGROUND ISOLATE
  //═════════════════════════════════════════

  //═══════════════════════════════════════════════
  // PUBLIC UTILS
  //═══════════════════════════════════════════════

  static Future<String?> getToken() async =>
      FirebaseMessaging.instance.getToken();

  static Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  }
}

//understanding :->
//-----------------------
// for (final entry in initial.data.entries) {
// await prefs.setString('$_pendingPrefix${entry.key}', entry.value.toString());
// }

// // FCM se aaya data:
// {
// "type": "NEW_RIDE",
// "role": "rider",
// "ride_id": "2450",
// "pickup": "Indore",
// "drop": "Rajwada",
// "amount": "150"
// }
//
// // Prefs mein save hoga:
// notif_pending_type     = "NEW_RIDE"
// notif_pending_role     = "rider"
// notif_pending_ride_id  = "2450"
// notif_pending_pickup   = "Indore"
// notif_pending_drop     = "Rajwada"
// notif_pending_amount   = "150"

//consumePendingTap :->
// // Step 1 — Prefs kholo, saari notif_pending_ wali keys dhundho:
// final allKeys = prefs.getKeys().where((k) => k.startsWith(_pendingPrefix)).toList();
//
// // Mila:
// // ["notif_pending_type", "notif_pending_role", "notif_pending_ride_id"]
//
// Step 2 — Koi key nahi mili? Matlab killed tap nahi tha, return:
// if (allKeys.isEmpty) return;

// Step 3 — Keys se original map reconstruct karo:
// notif_pending_type → type
// notif_pending_role → role
// notif_pending_ride_id → ride_id
//
// data = {
// "type": "NEW_RIDE",
// "role": "rider",
// "ride_id": "2450"
// }

// Step 4 — Pehle clear karo — duplicate na ho:
// await prefs.remove("notif_pending_type");
// await prefs.remove("notif_pending_role");
// await prefs.remove("notif_pending_ride_id");

// Step 5 — Handler ko do:
// await AppNotificationHandler.onKilledTap(data);
// // ✏️ Tu yahan apna logic likhega

//Prefs → Keys dhundho → Map banao → Clear karo → onKilledTap() ✅

// depedency ->
// dependencies:
// firebase_core: ^latest
// firebase_messaging: ^latest
// flutter_local_notifications: ^latest
// shared_preferences: ^latest

// consumePendingTap
//
// () ko
//
// main.dart me
// nahi,
//
// balki SplashScreen
//
// me call
//
// karna hai
// —
//
// jab tak
//
// app ka
// Navigator/
//
// context ready
//
// ho chuka
// ho,
//
// jaise file
//
// me comment
//
// bhi likha
// hai: "
// SplashScreen se call karo — navigate ke baad
// "
// .

//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }
//
//   Future<void> _init() async {
//     // tumhara existing splash logic — token check, delay, etc.
//     await Future.delayed(const Duration(seconds: 2));
//
//     // navigate to home/login (jo bhi tumhara normal flow hai)
//     if (!mounted) return;
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) => const HomeScreen()),
//     );
//
//     // ✅ Navigate ke baad — killed-state pending tap consume karo
//     await NotificationService.consumePendingTap();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(body: Center(child: CircularProgressIndicator()));
//   }
// }
