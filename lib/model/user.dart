import 'package:hive/hive.dart';

class User extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int phoneNumber;
  User({
    required this.name,
    required this.phoneNumber,
  });
}
