class ErrorMessageModel {
  String? error;

  ErrorMessageModel({this.error});

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      error: json['error'] as String?,
    );
  }
}
