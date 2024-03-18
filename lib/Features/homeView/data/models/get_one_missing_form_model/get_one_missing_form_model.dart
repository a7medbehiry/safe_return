import 'missing_one_report.dart';

class GetOneMissingFormModel {
  String? message;
  MissingOneReport? report;

  GetOneMissingFormModel({this.message, this.report});

  factory GetOneMissingFormModel.fromJson(
      Map<String, dynamic> json) {
    return GetOneMissingFormModel(
      message: json['message'] as String?,
      report: json['report'] == null
          ? null
          : MissingOneReport
              .fromJson(
                  json['report'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic>
      toJson() {
    return {
      'message': message,
      'report': report
          ?.toJson(),
    };
  }
}
