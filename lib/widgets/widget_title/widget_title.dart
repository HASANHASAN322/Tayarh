import 'package:flutter/material.dart';
import 'package:tayarh/utils/constant/text_strings.dart';

import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';

class WidgetTitle extends StatelessWidget {
  const WidgetTitle({
    super.key,
    required this.title,
    required this.image,
    required this.bgColor,
     this.points,
    required this.isPoint,
    this.cash,
  });

  final String title;
  final String image;
  final String? points;
  final String? cash;
  final Color bgColor;
  final bool isPoint;

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(MySize.defaultSpace),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    color: dark ? MyColors.whiteColor : MyColors.blackColor),
              ),
              Image(image: AssetImage(image)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          isPoint
              ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      points!,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: dark ? MyColors.whiteColor : MyColors.blackColor),
                    ),
                ],
              )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '\$',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color:
                             MyColors.greenColor),
                        ),
                        const SizedBox(width: 5,) ,
                        Text(
                          cash!,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color:
                                  dark ? MyColors.whiteColor : MyColors.blackColor),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: MyColors.greenColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Text(
                          MyTexts.addFounds,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: dark
                                  ? MyColors.whiteColor
                                  : MyColors.blackColor),
                        ),
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
