import 'package:flutter/material.dart';
import 'package:tayarh/theme/text_field_theme.dart';
import 'package:tayarh/theme/text_theme.dart';

import '../utils/constant/colors.dart';

class MyAppTheme {
  MyAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: MyColors.mainColor,
      textTheme: MyTextTheme.lightTextTheme,
      scaffoldBackgroundColor: MyColors.whiteColor,
      inputDecorationTheme: MyTextFormFieldTheme.lightInputDecorationTheme
  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: MyColors.mainColor,
      textTheme: MyTextTheme.darkTextTheme,
      scaffoldBackgroundColor: MyColors.darkColor,
      inputDecorationTheme: MyTextFormFieldTheme.darkInputDecorationTheme
  );


}