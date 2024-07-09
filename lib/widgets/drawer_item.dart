import 'package:flutter/material.dart';
import 'package:tayarh/utils/constant/colors.dart';

import '../theme/dark_mode.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {required this.name,
      required this.icon,
      required this.onPress,
      super.key});
  final String name;
  final String icon;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);

    return InkWell(
      onTap: onPress,
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
           Image.asset(icon),
            const SizedBox(
              width: 20,
            ),
            Text(
              name,
              style:  TextStyle(fontSize: 15, color: dark ? MyColors.whiteColor : MyColors.blackColor),
            )
          ],
        ),
      ),
    );
  }
}
