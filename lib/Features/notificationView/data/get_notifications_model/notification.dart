import 'recieved_id.dart';

class Notifications {
  String? id;
  String? body;
  ReceivedId? receivedId;
  String? date;

  Notifications({this.id, this.body, this.receivedId, this.date});

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['_id'] as String?,
      body: json['body'] as String?,
      receivedId: json['recievedId'] == null
          ? null
          : ReceivedId.fromJson(json['recievedId'] as Map<String, dynamic>),
      date: json['date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'body': body,
      'recievedId': receivedId?.toJson(),
      'date': date,
    };
  }
}
