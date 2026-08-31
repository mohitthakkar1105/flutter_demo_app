import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'logger.dart';

@pragma('vm:entry-point')
class AppNotificationHandler {
  AppNotificationHandler._();

  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  //═══════════════════════════════════════════════
  // CHANNELS
  //═══════════════════════════════════════════════

  static const _defaultChannelId = 'default_channel';
  static const _defaultChannelName = 'Notifications';

  //═══════════════════════════════════════════════
  // INIT
  //═══════════════════════════════════════════════

  static Future<void> initLocal() async {
    await _createChannels();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _local.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) async {
        final data = _decode(response.payload);
        await onForeground_tap(data);
      },
    );
  }

  static Future<void> _createChannels() async {
    final androidPlugin = _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (androidPlugin == null) return;

    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        _defaultChannelId,
        _defaultChannelName,
        description: 'App notifications',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      ),
    );
  }

  //═══════════════════════════════════════════════
  // 1. FOREGROUND
  //═══════════════════════════════════════════════

  static Future<void> onForeground(RemoteMessage message) async {
    FcmLogger.logMessage(message, state: FcmState.foreground);

    if (message.notification == null && message.data.isEmpty) {
      return;
    }
    await _showLocal(
      title: message.notification?.title ?? "Notification",
      body: message.notification?.body ?? "",
      data: message.data,
    );
  }

  //═══════════════════════════════════════════════
  // 2. FOREGROUND LOCAL NOTIFICATION TAP
  //═══════════════════════════════════════════════

  static Future<void> onForeground_tap(Map<String, dynamic> data) async {
    FcmLogger.logData("👆 FOREGROUND TAP", data);
    await _handleData(data);
  }

  //═══════════════════════════════════════════════
  // 3. BACKGROUND TAP
  //═══════════════════════════════════════════════

  static Future<void> onBackground_tap(RemoteMessage message) async {
    FcmLogger.logMessage(message, state: FcmState.tap);
    await _handleData(message.data);
  }

  //═══════════════════════════════════════════════
  // 4. KILLED TAP
  //═══════════════════════════════════════════════

  static Future<void> onKilledTap(Map<String, dynamic> data) async {
    FcmLogger.logData("👆 KILLED TAP", data);
    await _handleData(data);
  }

  //═══════════════════════════════════════════════
  // BACKGROUND MESSAGE — sirf log
  //═══════════════════════════════════════════════

  @pragma('vm:entry-point')
  static Future<void> onBackground(RemoteMessage message) async {
    FcmLogger.logMessage(message, state: FcmState.background);
    print("background me aaya ----------------");
  }

  //═══════════════════════════════════════════════
  // MAIN HANDLER
  //═══════════════════════════════════════════════

  static Future<void> _handleData(Map<String, dynamic> data) async {
    // tap logic for all state types
  }

  //═══════════════════════════════════════════════
  // LOCAL NOTIFICATION SHOW
  //═══════════════════════════════════════════════

  static Future<void> _showLocal({
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      _defaultChannelId,
      _defaultChannelName,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: 'ic_notification',
    );

    const iosDetails = DarwinNotificationDetails();

    await _local.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      payload: _encode(data),
    );
  }

  //═══════════════════════════════════════════════
  // HELPERS
  //═══════════════════════════════════════════════

  static String _encode(Map<String, dynamic> data) {
    try {
      return jsonEncode(data);
    } catch (e) {
      return "";
    }
  }

  static Map<String, dynamic> _decode(String? payload) {
    if (payload == null || payload.isEmpty) return {};
    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map<String, dynamic>) return decoded;
      return {};
    } catch (e) {
      return {};
    }
  }
}


// dhyan rahe ye bhi add karna hai -(1)-->

// WidgetsFlutterBinding.ensureInitialized();
//
// await Firebase.initializeApp(
// options: DefaultFirebaseOptions.currentPlatform,
// );
//
// await NotificationService.init();

// ------------------------------------------------------------------------

// ye add karna for locala notification in kts----(2)------>
// dependencies {
// coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
// }

// or

//         isCoreLibraryDesugaringEnabled = true in compiler option

// ------------------------------------------------------------------------


// -------------sha-----------(3)-->
// cd android
//     ./gradlew signingReport
