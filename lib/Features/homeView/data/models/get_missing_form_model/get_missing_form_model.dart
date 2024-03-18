import 'missing_report.dart';

class GetMissingFormModel {
  String? message;
  List<MissingReport>? reports;

  GetMissingFormModel({this.message, this.reports});

  factory GetMissingFormModel.fromJson(
      Map<String, dynamic> json) {
    return GetMissingFormModel(
      message: json['message'] as String?,
      reports: (json['reports'] as List<dynamic>?)
          ?.map((e) => MissingReport
              .fromJson(
                  e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic>
      toJson() {
    return {
      'message': message,
      'reports': reports
          ?.map((e) => e
              .toJson())
          .toList(),
    };
  }
}
