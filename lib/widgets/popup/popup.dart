
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/theme/dark_mode.dart';
import 'package:tayarh/utils/constant/colors.dart';


class MyPobUp {
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar() ;

  static customToast({required message}){
    ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
            elevation: 0,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.transparent,
            content: Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30) ,
                  color: DarkMode.isDarkMode(Get.context!) ? MyColors.whiteColor.withOpacity(0.9) : MyColors.darkColor.withOpacity(0.9)
              ),
              child: Center(child: Text(message , style: Theme.of(Get.context!).textTheme.labelLarge,),),
            ) )
    ) ;
  }

  static successSnackBar({required title, message = '', duration = 4}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: MyColors.mainColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon:  Icon(
          Icons.check_circle_sharp,
          color: MyColors.whiteColor,
        ));
  }
  static warningSnackBar({required title, message = '', }) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(20),
        icon:  Icon(
          Icons.warning,
          color: MyColors.whiteColor,
        ));
  }

  static errorSnackBar({required title, message = '', duration = 4}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(20),
        icon:  Icon(
          Icons.warning,
          color: MyColors.whiteColor,
        ));
  }
}
