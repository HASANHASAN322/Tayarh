import 'package:flutter/material.dart';
import 'package:tayarh/screens/authentication/login/login.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const GetMaterialApp(
      debugShowCheckedModeBanner: false,
        home: Login());
  }
}
