class MissingReport {
  String? firstReporterName;
  String? lastReporterName;
  String? phoneNumber;
  int? nationalId;
  String? governorate;
  DateTime? date;
  bool? found;
  String? createdBy;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MissingReport({
    this.firstReporterName,
    this.lastReporterName,
    this.phoneNumber,
    this.nationalId,
    this.governorate,
    this.date,
    this.found,
    this.createdBy,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MissingReport.fromJson(Map<String, dynamic> json) {
    return MissingReport(
      firstReporterName: json['firstReporterName'] as String?,
      lastReporterName: json['lastReporterName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      nationalId: json['nationalID'] as int?,
      governorate: json['governorate'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      found: json['found'] as bool?,
      createdBy: json['createdBy'] as String?,
      id: json['_id'] as String?,
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
      'firstReporterName': firstReporterName,
      'lastReporterName': lastReporterName,
      'phoneNumber': phoneNumber,
      'nationalID': nationalId,
      'governorate': governorate,
      'date': date?.toIso8601String(),
      'found': found,
      'createdBy': createdBy,
      '_id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}
