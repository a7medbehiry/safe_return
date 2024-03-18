import 'find_one_report.dart';

class GetOneFindFormModel {
  String? message;
  FindOneReport? report;

  GetOneFindFormModel({this.message, this.report});

  factory GetOneFindFormModel.fromJson(Map<String, dynamic> json) {
    return GetOneFindFormModel(
      message: json['message'] as String?,
      report: json['report'] == null
          ? null
          : FindOneReport.fromJson(json['report'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'report': report?.toJson(),
    };
  }
}
