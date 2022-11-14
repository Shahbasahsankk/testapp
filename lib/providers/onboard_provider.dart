import 'package:flutter/material.dart';

import '../views/login/login_screen.dart';

class OnboardProvider with ChangeNotifier {
  late PageController pageController;

  void goToLoginScreen(context) {
    Navigator.of(context).pushAndRemoveUntil(
        (MaterialPageRoute(
          builder: (context) => LoginScreen(),
        )),
        (route) => false);
  }
}
