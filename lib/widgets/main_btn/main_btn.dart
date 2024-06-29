import 'package:flutter/material.dart';
import 'package:tayarh/theme/dark_mode.dart';
import 'package:tayarh/utils/constant/colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = 90,
    this.height = 35,
    this.fontSize = 18,
    this.isBlue = true,
  });

  final String title;
  final double width;
  final double height;
  final double fontSize;
  final bool isBlue;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: isBlue
                ? MyColors.mainColor
                : dark
                    ? MyColors.darkColor.withOpacity(0.8)
                    : MyColors.whiteColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: fontSize,
                color: isBlue
                    ? MyColors.whiteColor
                    : dark
                        ? MyColors.whiteColor
                        : MyColors.blackColor),
          ),
        ),
      ),
    );
  }
}
