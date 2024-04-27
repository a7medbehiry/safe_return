import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';


class FirebaseNotifications {
  // Create instance of FBM
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notification for this app or device
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    log("Token : $token");
    handleBackgroundNotifications();
  }

  // handle notifications when received
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    
  }

  // handle notifications in case of app is terminated
  Future handleBackgroundNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
