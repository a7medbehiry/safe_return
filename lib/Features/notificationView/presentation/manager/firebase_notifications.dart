import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/core/utils/app_router.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseNotifications {
  // Create instance of FBM
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notification for this app or device
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    String? fcmToken = await _firebaseMessaging.getToken();
    log("FCM Token: $fcmToken");
    handleBackgroundNotifications();

    // PushNotificationsService(Dio()).pushNotifications(
    //   fcmToken: fcmToken,
    // );

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('fcmToken', "$fcmToken");

    // final SharedPreferences preferences = await SharedPreferences.getInstance();
    // var fcmToken = preferences.getString('fcmToken');
  }

  // handle notifications when received
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    AppRouter.navigatorKey.currentState!.context.goNamed('notificationView');
  }

  //handle notifications in case of app is terminated
  Future handleBackgroundNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Title: ${message.notification!.title}");
      log("Body: ${message.notification!.body}");
      SnackBarManager.showSnackBarNotification(message.notification?.body);
    });
  }
}
