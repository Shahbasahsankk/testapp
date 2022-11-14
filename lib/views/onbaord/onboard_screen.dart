import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/views/onbaord/utils/onbaord_list.dart';

import '../../providers/onboard_provider.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onbaordProvider =
        Provider.of<OnboardProvider>(context, listen: false);
    onbaordProvider.pageController = PageController();
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          itemCount: OnboardList().onboardList.length,
          controller: onbaordProvider.pageController,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 150,
                    width: 150,
                    image:
                        AssetImage(OnboardList().onboardList[index].imagePath),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    OnboardList().onboardList[index].bodyText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  index == 1
                      ? Container(
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.blue)),
                          child: TextButton(
                            onPressed: () =>
                                onbaordProvider.goToLoginScreen(context),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      : const Text('Swipe right')
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
