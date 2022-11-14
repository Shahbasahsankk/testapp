import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/constants/app_sizedboxes.dart';

import '../../providers/splash_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashProvider.checkLogin(context);
    });
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Image(
                image: AssetImage('assets/images-removebg-preview (1).png'),
              ),
            ),
            AppsizedBoxes.sizedBoxH40,
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'USERWEATHER',
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                  colors: [
                    Colors.red,
                    Colors.blue,
                    Colors.black,
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
