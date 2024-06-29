

import 'dart:ui';
import 'package:get/get.dart';
import 'package:tayarh/theme/dark_mode.dart';

class MyColors{
  static Color mainColor = const Color(0xff00B6FF);
  static Color whiteColor = const Color(0xffffffff);
  static Color blackColor = const Color(0xff000000);
  static Color borderColor = const Color(0x1A000000);
  static Color darkColor = const Color(0xff3F4B56);
  static Color hintColor = const Color(0xff00B6FF);
  static Color greenColor = const Color(0xff0BC9A4);
  static Color redColor = const Color(0xffF32F53);
  static Color textColor = DarkMode.isDarkMode(Get.context!) ? const Color(0xff383838) : const Color(0xffffffff);
  static Color backgroundColor = DarkMode.isDarkMode(Get.context!) ? const Color(0xff3F4B56) : const Color(0xffffffff);
  static Color buttonsColor = DarkMode.isDarkMode(Get.context!) ? const Color(0xff3F4B56) : const Color(0xffffffff);

}