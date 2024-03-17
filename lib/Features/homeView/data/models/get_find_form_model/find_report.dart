import 'created_by.dart';
import 'image.dart';

class FindReport {
  String? id;
  String? firstReporterName;
  String? lastReporterName;
  String? phoneNumber;
  String? governorate;
  DateTime? date;
  Image? image;
  String? childName;
  int? age;
  bool? exist;
  CreatedBy? createdBy;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? description;

  FindReport({
    this.id,
    this.firstReporterName,
    this.lastReporterName,
    this.phoneNumber,
    this.governorate,
    this.date,
    this.image,
    this.childName,
    this.age,
    this.exist,
    this.createdBy,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  factory FindReport.fromJson(Map<String, dynamic> json) {
    return FindReport(
      id: json['_id'] as String?,
      firstReporterName: json['firstReporterName'] as String?,
      lastReporterName: json['lastReporterName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      governorate: json['governorate'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
      childName: json['childName'] as String?,
      age: json['age'] as int?,
      exist: json['exist'] as bool?,
      createdBy: json['createdBy'] == null
          ? null
          : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
      v: json['__v'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstReporterName': firstReporterName,
      'lastReporterName': lastReporterName,
      'phoneNumber': phoneNumber,
      'governorate': governorate,
      'date': date?.toIso8601String(),
      'image': image?.toJson(),
      'childName': childName,
      'age': age,
      'exist': exist,
      'createdBy': createdBy?.toJson(),
      '__v': v,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'description': description,
    };
  }
}
