import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/home/home_screen.dart';

class LoginProvider with ChangeNotifier {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool signingIn = false;

  String? userNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username or emailaddress';
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter you password';
    }
    return null;
  }

  void login(context, FormState currentState) async {
    final userName = userNameController.text;
    final password = passwordController.text;
    if (currentState.validate()) {
      if (userName == 'testapp@google.com' && password == 'Test@123456') {
        signingIn = true;
        notifyListeners();
        await Future.delayed(
          const Duration(seconds: 3),
        );
        final sharedPrefs = await SharedPreferences.getInstance();
        sharedPrefs.setBool('Logined', true);
        Navigator.of(context).pushAndRemoveUntil(
            (MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            )),
            (route) => false);
        userNameController.clear();
        passwordController.clear();
        signingIn = false;
        notifyListeners();
      } else {
        Fluttertoast.showToast(
            msg: 'Invalid Username or Password', backgroundColor: Colors.red);
      }
    }
  }
}
