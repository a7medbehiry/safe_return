import 'find_report.dart';

class GetFindFormModel {
  String? message;
  List<FindReport>? reports;

  GetFindFormModel({this.message, this.reports});

  factory GetFindFormModel.fromJson(Map<String, dynamic> json) {
    return GetFindFormModel(
      message: json['message'] as String?,
      reports: (json['reports'] as List<dynamic>?)
          ?.map((e) => FindReport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'reports': reports?.map((e) => e.toJson()).toList(),
    };
  }
}
