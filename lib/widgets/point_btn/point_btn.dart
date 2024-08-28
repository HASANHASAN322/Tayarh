
import 'package:flutter/material.dart';
import 'package:tayarh/utils/constant/colors.dart';


import '../../theme/dark_mode.dart';
import '../../utils/constant/text_strings.dart';

class PointButton extends StatelessWidget {
  const PointButton({super.key, required this.points, required this.onTap});

  final String points ;
  final void Function() onTap ;
  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          color: dark ? MyColors.darkColor.withOpacity(0.8) : MyColors.whiteColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: MyColors.mainColor.withOpacity(0.1),
              child: Icon(
                Icons.flight,
                color: MyColors.mainColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 5,) ,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$points',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: dark ? MyColors.whiteColor : MyColors.darkColor,
                  ),
                ),
                const Text(
                  MyTexts.points,
                  style: TextStyle(fontSize: 10),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
