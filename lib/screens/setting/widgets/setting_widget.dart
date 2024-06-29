import 'package:flutter/material.dart';
import 'package:tayarh/utils/constant/size.dart';

import '../../../theme/dark_mode.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/text_strings.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    super.key, required this.text, required this.value, required this.onTap,

  });

  final String text ;
  final String value ;
  final void Function() onTap ;


  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    return Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: MySize.spaceBtwItems / 2),
      decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: MyColors.borderColor),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 14,
                      color: dark
                          ? MyColors.whiteColor
                          : MyColors.blackColor),
                ),
                TextButton(
                    onPressed: onTap,
                    child: Text(
                      MyTexts.change,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: MyColors.mainColor),
                    ))
              ],
            ),

            /// value
            Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
