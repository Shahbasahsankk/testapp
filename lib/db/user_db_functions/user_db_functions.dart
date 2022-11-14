import 'package:hive/hive.dart';

import '../../models/user_model/user_model.dart';

class UserDBFunctions {
  static List<UserModel> userList = [];

  Future<List<UserModel>> addUser(UserModel value) async {
    final userDB = await Hive.openBox<UserModel>('user_db');
    await userDB.put(value.id, value);
    userList.add(value);
    return userList;
  }

  Future<List<UserModel>> getAllUsers() async {
    final userDB = await Hive.openBox<UserModel>('user_db');
    userList.clear();
    userList.addAll(userDB.values);
    return userList;
  }

  Future<void> deleteUser(id) async {
    final userDB = await Hive.openBox<UserModel>('user_db');
    await userDB.delete(id);
    getAllUsers();
  }
}
