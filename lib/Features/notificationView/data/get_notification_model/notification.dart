class Notifications {
  String? id;
  String? body;
  String? date;

  Notifications({this.id, this.body, this.date});

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['_id'] as String?,
      body: json['body'] as String?,
      date: json['date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'body': body,
      'date': date,
    };
  }
}
