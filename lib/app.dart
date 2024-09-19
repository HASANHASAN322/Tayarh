import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/binding/initial_bindings.dart';
import 'package:tayarh/routes/page_routes.dart';
import 'package:tayarh/routes/routes.dart';
import 'package:tayarh/theme/app_theme.dart';
import 'package:tayarh/utils/language/lang_translation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
      locale: Locale('en', 'US'),
      translations: MyTranslations(),
      fallbackLocale: Locale('en', 'US'),
        initialRoute: Routes.login,
        themeMode: ThemeMode.system,
        theme: MyAppTheme.lightTheme,
        darkTheme: MyAppTheme.darkTheme,
        getPages: routes,
    );
  }
}
