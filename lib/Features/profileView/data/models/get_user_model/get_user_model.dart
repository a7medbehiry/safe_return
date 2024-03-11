import 'user.dart';

class GetUserModel {
  String? message;
  User? user;
  String? token;

  GetUserModel({this.message, this.user, this.token});

  factory GetUserModel.fromJson(Map<String, dynamic> json) {
    return GetUserModel(
      message: json['message'] as String?,
      user: json['User'] == null
          ? null
          : User.fromJson(json['User'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'User': user?.toJson(),
      'token': token,
    };
  }
}
