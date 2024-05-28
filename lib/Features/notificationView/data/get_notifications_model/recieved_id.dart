class ReceivedId {
  String? id;
  String? userName;

  ReceivedId({this.id, this.userName});

  factory ReceivedId.fromJson(
      Map<String, dynamic> json) {
    return ReceivedId(
      id: json['_id'] as String?,
      userName: json['userName'] as String?,
    );
  }

  Map<String, dynamic>
      toJson() {
    return {
      '_id': id,
      'userName': userName,
    };
  }
}
