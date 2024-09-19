import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/screens/authentication/login/controller/login_controller.dart';
import 'package:tayarh/theme/dark_mode.dart';
import 'package:tayarh/utils/constant/text_strings.dart';

import '../../utils/constant/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    final controller = Get.put(LoginController());
    return AppBar(
        backgroundColor: dark ? MyColors.darkColor : MyColors.whiteColor,
        title: Text(MyTexts.signIn,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: dark ? MyColors.whiteColor : MyColors.blackColor)),
        actions: [
          Obx(() => Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: MyColors.borderColor),
                    borderRadius: BorderRadius.circular(5)),
                height: 38,
                width: 100,
                child: DropdownButton(
                    underline: const SizedBox(),
                    dropdownColor:
                        dark ? MyColors.blackColor : MyColors.whiteColor,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16,
                    ),
                    items: ['English', 'Arabic']
                        .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(
                              option,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: dark
                                      ? MyColors.whiteColor
                                      : MyColors.blackColor),
                            )))
                        .toList(),
                    value: controller.selectedLanguage.value,
                    onChanged: (value) {
                      controller.changeLanguage(value!);
                    }),
              ))
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
