import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String userName;
  @HiveField(1)
  String phoneNumber;
  @HiveField(2)
  String governorate;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  String email;

  UserModel({
    required this.userName,
    required this.phoneNumber,
    required this.governorate,
    required this.date,
    required this.email,
  });
}
