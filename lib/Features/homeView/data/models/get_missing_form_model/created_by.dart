class CreatedBy {
  String? id;
  String? userName;

  CreatedBy({this.id, this.userName});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json['_id'] as String?,
        userName: json['userName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userName': userName,
      };
}
