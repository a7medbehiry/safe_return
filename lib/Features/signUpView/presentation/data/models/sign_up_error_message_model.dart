class SignUPErrorMessageModel {
  String? error;

  SignUPErrorMessageModel({this.error});

  factory SignUPErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return SignUPErrorMessageModel(
      error: json['error'] as String?,
    );
  }
}