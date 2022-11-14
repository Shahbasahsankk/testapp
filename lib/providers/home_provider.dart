import 'package:flutter/material.dart';

import '../db/user_db_functions/user_db_functions.dart';
import '../models/user_model/user_model.dart';
import '../views/add_user/add_user_screen.dart';
import '../views/home/widgets/delete_alert_dialogue.dart';
import '../views/weather/weather_screen.dart';

class HomeProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  bool visible = false;
  bool isSwitched = false;
  List<UserModel> allUsers = [];
  List<UserModel> foundUsers = [];

  void searchStudent(String value) async {
    List<UserModel> result = [];
    if (value.isEmpty) {
      allUsers = await UserDBFunctions().getAllUsers();
      foundUsers = allUsers;
    } else {
      allUsers = await UserDBFunctions().getAllUsers();
      result = allUsers
          .where((element) =>
              element.firstName.toLowerCase().contains(value.toLowerCase()))
          .toList();
      foundUsers = result;
    }
    notifyListeners();
  }

  Future<void> delete(id) async {
    await UserDBFunctions().deleteUser(id);
    notifyListeners();
  }

  void switchOnOff(bool value) {
    isSwitched = value;
    notifyListeners();
  }

  void searchOnOff(value) {
    if (value == true) {
      visible = true;
    } else {
      visible = false;
    }
    notifyListeners();
  }

  Future<bool?> deleteShowDialogue(
      id, context, HomeProvider searchProvider) async {
    return showDialog<bool>(
      context: context,
      builder: (ctx) {
        return DeleteDialogue().deleteDialougue(
            context, id, searchProvider, searchController.text);
      },
    );
  }

  void toAddUserScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddScreen(),
      ),
    );
  }

  void toWeatherScreen(BuildContext context, toggleValue) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
          toggleValue: toggleValue,
        ),
      ),
    );
  }
}
