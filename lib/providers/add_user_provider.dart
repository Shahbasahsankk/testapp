import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../db/user_db_functions/user_db_functions.dart';
import '../models/user_model/user_model.dart';
import '../views/home/home_screen.dart';

class AddUserProvider with ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  List<UserModel> list = [];
  bool saving = false;

  void get() async {
    list = await UserDBFunctions().getAllUsers();
    notifyListeners();
  }

  void add(UserModel value) async {
    list = await UserDBFunctions().addUser(value);
    notifyListeners();
  }

  String? nameValidation(String? value, text) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $text';
    }
    return null;
  }

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  void clearControllers() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    notifyListeners();
  }

  void save(BuildContext context, FormState currentState) async {
    if (currentState.validate()) {
      saving = true;
      notifyListeners();
      final userModel = UserModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
      );
      add(userModel);
      await Future.delayed(
        const Duration(seconds: 2),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
      saving = false;
      notifyListeners();
      Fluttertoast.showToast(msg: 'User added', backgroundColor: Colors.green);
    }
  }

  void cancel(BuildContext context) {
    Navigator.of(context).pop();
  }
}
