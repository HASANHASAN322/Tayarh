import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/screens/authentication/login/login.dart';
import 'package:tayarh/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return   GetMaterialApp(
      debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: MyAppTheme.lightTheme,
        darkTheme: MyAppTheme.darkTheme,
        home:  const Login());
  }
}
