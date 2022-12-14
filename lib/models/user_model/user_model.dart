import 'package:hive_flutter/adapters.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String firstName;
  @HiveField(1)
  final String lastName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String id;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.id,
  });
}
