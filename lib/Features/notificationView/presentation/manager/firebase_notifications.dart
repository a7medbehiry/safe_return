import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/core/utils/app_router.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseNotifications {
  // Create an instance of FirebaseMessaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notifications for this app or device
  Future<void> initNotifications() async {
    // Request permission for notifications
    await _firebaseMessaging.requestPermission();

    // Get the FCM token and log it
    String? fcmToken = await _firebaseMessaging.getToken();
    log("FCM Token: $fcmToken");

    // Save the FCM token to shared preferences
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('fcmToken', fcmToken ?? '');

    // Handle notifications
    handleBackgroundNotifications();
  }

  // Handle notifications when received
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // Navigate to the notification view
    AppRouter.navigatorKey.currentState?.context.goNamed('notificationView');
  }

  // Handle notifications in case the app is terminated
  Future<void> handleBackgroundNotifications() async {
    // Handle the message if the app was opened from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Handle the message if the app was brought to the foreground
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Handle the message when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        log("Title: ${message.notification!.title}");
        log("Body: ${message.notification!.body}");
        SnackBarManager.showSnackBarNotification(message.notification?.body);
      }
    });
  }
}
