import 'package:flutter/material.dart';
import 'package:tayarh/screens/setting/widgets/setting_widget.dart';

import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../utils/constant/text_strings.dart';

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
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: dark ? MyColors.darkColor : MyColors.whiteColor),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: 80,
              height: 10,
              decoration: BoxDecoration(
                  color: MyColors.borderColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: MySize.spaceBtwSections,
            ),

            /// header
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                MyTexts.setting,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: dark ? MyColors.whiteColor : MyColors.blackColor),
              ),
            ]),

            const SizedBox(
              height: MySize.spaceBtwItems,
            ),

            SettingWidget(
              onTap: () {},
              value: '09999999',
              text: MyTexts.phoneNumber,
            ),
            SettingWidget(
              onTap: () {},
              value: 'Default Language',
              text: MyTexts.language,
            ),
            SettingWidget(
              onTap: () {},
              value: 'System Theme',
              text: MyTexts.theme,
            ),

            /// logout and delete account
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
                              color: dark
                                  ? MyColors.whiteColor
                                  : MyColors.blackColor),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          MyTexts.deleteAccount,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: MyColors.redColor),
                        )),
                  ],
                ),
              ],
            )
          ]),
        ));
  }
}
