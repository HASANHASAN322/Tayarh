import 'package:flutter/material.dart';
import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/image_strings.dart';
import '../../utils/constant/text_strings.dart';

class WhereToWidget extends StatelessWidget {
  const WhereToWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: dark
            ? MyColors.darkColor.withOpacity(0.8)
            : MyColors.whiteColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 10,
            decoration: BoxDecoration(
                color: MyColors.borderColor,
                borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: dark
                    ? MyColors.hintColor.withOpacity(0.6)
                    : MyColors.hintColor.withOpacity(0.2)),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  MyImage.searchIcon,
                ),
                hintText: 'Where to?',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: dark ? MyColors.whiteColor : MyColors.darkColor,
                ),
              ),
              onSubmitted: (value) {
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            MyTexts.safety,
            style: TextStyle(
                color: dark ? MyColors.whiteColor : MyColors.darkColor,
                fontSize: 12),
          )
        ],
      ),
    );
  }
}