import 'notification.dart';

class GetNotificationsModel {
  String? message;
  List<Notifications>? notifications;

  GetNotificationsModel({this.message, this.notifications});

  factory GetNotificationsModel.fromJson(Map<String, dynamic> json) {
    return GetNotificationsModel(
      message: json['message'] as String?,
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => Notifications.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'notifications': notifications?.map((e) => e.toJson()).toList(),
    };
  }
}
