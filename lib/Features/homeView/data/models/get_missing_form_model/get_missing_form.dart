import 'missing_report.dart';

class GetMissingFormModel {
  String? message;
  MissingReport? report;

  GetMissingFormModel({this.message, this.report});

  factory GetMissingFormModel.fromJson(Map<String, dynamic> json) {
    return GetMissingFormModel(
      message: json['message'] as String?,
      report: json['report'] == null
          ? null
          : MissingReport.fromJson(json['report'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'report': report?.toJson(),
    };
  }
}
