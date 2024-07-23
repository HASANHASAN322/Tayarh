import 'package:flutter/material.dart';
import 'package:tayarh/utils/sevices/services.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initialServices() ;
  MyServices() ;
  runApp(const MyApp());
}