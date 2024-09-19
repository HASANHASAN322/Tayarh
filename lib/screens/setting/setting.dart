import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/screens/setting/widgets/setting_widget.dart';

import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../utils/constant/text_strings.dart';
import '../authentication/login/controller/login_controller.dart';

class MySettings extends StatelessWidget {
  const MySettings({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);


    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(MySize.defaultSpace),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: dark ? MyColors.darkColor : MyColors.whiteColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 80,
              height: 10,
              decoration: BoxDecoration(
                color: MyColors.borderColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              height: MySize.spaceBtwSections,
            ),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  MyTexts.setting,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: dark ? MyColors.whiteColor : MyColors.blackColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: MySize.spaceBtwItems,
            ),
            // Phone Number Setting
            SettingWidget(
              onTap: () {},
              value: '09999999',
              text: MyTexts.phoneNumber,
            ),
            // Language Setting
            GetX<LoginController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingWidget(
                      onTap: () {
                        controller.toggleDropdown();
                      },
                      value: 'Default Language',
                      text: MyTexts.language,
                    ),
                    controller.showDropdown.value
                        ? Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: MyColors.borderColor,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
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
                                  : MyColors.blackColor,
                            ),
                          ),
                        ))
                            .toList(),
                        value: controller.selectedLanguage.value,
                        onChanged: (value) {
                          controller.changeLanguage(value!);
                        },
                      ),
                    )
                        : SizedBox(),
                  ],
                );
              },
            ),
            // Theme Setting
            SettingWidget(
              onTap: () {},
              value: 'System Theme',
              text: MyTexts.theme,
            ),
            // Logout and Delete Account
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        MyTexts.logout,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: dark ? MyColors.whiteColor : MyColors.blackColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        MyTexts.deleteAccount,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: MyColors.redColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
