import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:safe_return/core/utils/api_services.dart';

class FirebaseNotifications {
  // Create instance of FBM
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notification for this app or device
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    log("$token");
    // handleBackgroundNotifications();
    handleMessage;
    PushNotificationsService(Dio()).pushNotifications(fcmToken: token);
  }

  // handle notifications when received
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    log("Title: ${message.notification!.title}");
    log("Body: ${message.notification!.body}");
    log("Data: ${message.data}");
  }

  // // handle notifications in case of app is terminated
  // Future handleBackgroundNotifications() async {
  //   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  // }
}
