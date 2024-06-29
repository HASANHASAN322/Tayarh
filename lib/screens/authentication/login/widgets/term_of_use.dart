import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/dark_mode.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/text_strings.dart';
import '../controller/login_controller.dart';

class TermOfUseWidget extends StatelessWidget {
  const TermOfUseWidget({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = DarkMode.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 15,
          height: 15,
          child: Obx(() => Checkbox(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10)),
            activeColor: MyColors.mainColor,
            checkColor: MyColors.whiteColor,
            value: controller.privacyPolicy.value,
            onChanged: (value) =>
            controller.privacyPolicy.value =
            !controller.privacyPolicy.value,
          )),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          MyTexts.iAcceptThe,
          style: TextStyle(
              fontSize: 11,
              color: dark
                  ? MyColors.whiteColor
                  : MyColors.darkColor),
        ),
        Text(
          MyTexts.termOfServices,
          style: TextStyle(
              fontSize: 12, color: MyColors.mainColor),
        ),
        Text(
          MyTexts.and,
          style: TextStyle(
              fontSize: 11,
              color: dark
                  ? MyColors.whiteColor
                  : MyColors.darkColor),
        ),
        Flexible(
          child: Text(
            MyTexts.privacyPolicy,
            style: TextStyle(
                fontSize: 12, color: MyColors.mainColor),
          ),
        ),
      ],
    );
  }
}
