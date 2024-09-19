import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/theme/dark_mode.dart';
import 'package:tayarh/utils/constant/colors.dart';

class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'welcome'.tr,
              style: TextStyle(
                color: dark ? MyColors.whiteColor : MyColors.blackColor,
                fontSize: 36,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              ' Tayarh ',
              style: TextStyle(
                color: MyColors.mainColor,
                fontSize: 36,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Text(
          'pleaseEnterPhoneNumber'.tr,
          style: TextStyle(
            color: dark ? MyColors.whiteColor : MyColors.blackColor,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
