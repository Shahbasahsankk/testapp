import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/add_user_provider.dart';
import 'package:test_app/providers/home_provider.dart';
import 'package:test_app/providers/login_provider.dart';
import 'package:test_app/providers/onboard_provider.dart';
import 'package:test_app/providers/splash_provider.dart';
import 'package:test_app/providers/weather_provider.dart';
import 'package:test_app/views/home/home_screen.dart';
import 'package:test_app/views/splash/splash_screen.dart';

import 'models/user_model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddUserProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => OnboardProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
