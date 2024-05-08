import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';

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
  }

  // handle notifications when received
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    
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
