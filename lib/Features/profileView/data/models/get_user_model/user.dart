
import 'profile_pic.dart';

class User {
  String? id;
  String? fname;
  String? lname;
  String? email;
  String? password;
  String? role;
  DateTime? dob;
  String? gender;
  bool? verified;
  String? provider;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userName;
  int? v;
  DateTime? loggedOutAt;
  String? phoneNumber;
  String? governorate;
  ProfilePic? profilePic;

  User({
    this.id,
    this.fname,
    this.lname,
    this.email,
    this.password,
    this.role,
    this.dob,
    this.gender,
    this.verified,
    this.provider,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.v,
    this.loggedOutAt,
    this.phoneNumber,
    this.governorate,
    this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      fname: json['Fname'] as String?,
      lname: json['Lname'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      dob: json['DOB'] == null ? null : DateTime.parse(json['DOB'] as String),
      gender: json['gender'] as String?,
      verified: json['verified'] as bool?,
      provider: json['provider'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      userName: json['userName'] as String?,
      v: json['__v'] as int?,
      loggedOutAt: json['loggedOutAt'] == null
          ? null
          : DateTime.parse(json['loggedOutAt'] as String),
      phoneNumber: json['phoneNumber'] as String?,
      governorate: json['governorate'] as String?,
      profilePic: json['profilePic'] == null
          ? null
          : ProfilePic.fromJson(json['profilePic'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Fname': fname,
      'Lname': lname,
      'email': email,
      'password': password,
      'role': role,
      'DOB': dob?.toIso8601String(),
      'gender': gender,
      'verified': verified,
      'provider': provider,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'userName': userName,
      '__v': v,
      'loggedOutAt': loggedOutAt?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'governorate': governorate,
      'profilePic': profilePic?.toJson(),
    };
  }
}
