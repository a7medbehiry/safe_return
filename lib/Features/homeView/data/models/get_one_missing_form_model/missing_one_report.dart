import 'created_by.dart';

class MissingOneReport {
  String? id;
  String? firstReporterName;
  String? lastReporterName;
  String? phoneNumber;
  int? nationalId;
  String? governorate;
  DateTime? date;
  bool? found;
  CreatedBy? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MissingOneReport({
    this.id,
    this.firstReporterName,
    this.lastReporterName,
    this.phoneNumber,
    this.nationalId,
    this.governorate,
    this.date,
    this.found,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MissingOneReport.fromJson(Map<String, dynamic> json) {
    return MissingOneReport(
      id: json['_id'] as String?,
      firstReporterName: json['firstReporterName'] as String?,
      lastReporterName: json['lastReporterName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      nationalId: json['nationalID'] as int?,
      governorate: json['governorate'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      found: json['found'] as bool?,
      createdBy: json['createdBy'] == null
          ? null
          : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstReporterName': firstReporterName,
      'lastReporterName': lastReporterName,
      'phoneNumber': phoneNumber,
      'nationalID': nationalId,
      'governorate': governorate,
      'date': date?.toIso8601String(),
      'found': found,
      'createdBy': createdBy?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}
