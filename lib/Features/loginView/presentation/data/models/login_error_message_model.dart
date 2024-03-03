class LoginErrorMessageModel {
  String? error;

  LoginErrorMessageModel({this.error});

  factory LoginErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return LoginErrorMessageModel(
      error: json['error'] as String?,
    );
  }
}