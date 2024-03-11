import 'user.dart';

class GetUserModel {
  String? message;
  User? user;

  GetUserModel({this.message, this.user});

  factory GetUserModel.fromJson(Map<String, dynamic> json) {
    return GetUserModel(
      message: json['message'] as String?,
      user: json['User'] == null
          ? null
          : User.fromJson(json['User'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'User': user?.toJson(),
    };
  }
}
