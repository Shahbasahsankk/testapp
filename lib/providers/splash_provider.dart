import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/views/onbaord/onboard_screen.dart';

import '../views/home/home_screen.dart';
import '../views/login/login_screen.dart';

class SplashProvider with ChangeNotifier {
  void checkLogin(context) async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    final sharedPrefs = await SharedPreferences.getInstance();
    final loginData = sharedPrefs.getBool('Logined');
    if (loginData != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const OnboardScreen(),
          ),
          (route) => false);
    }
  }
}
