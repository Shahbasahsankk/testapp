import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/weather_provider.dart';

class LogOutDialougue extends StatelessWidget {
  const LogOutDialougue({super.key});
  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    return AlertDialog(
      content: const Text('Log out?'),
      actions: [
        TextButton(
          onPressed: () => weatherProvider.logOut(context),
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        )
      ],
    );
  }
}
