import 'package:flutter/material.dart';
import 'package:tayarh/utils/constant/text_strings.dart';

import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../widgets/progress_widget/progress_widget.dart';
import '../../widgets/widget_title/widget_title.dart';

class MyPoints extends StatelessWidget {
  const MyPoints({super.key});

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
      child: Column(
        children: [
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

          /// points
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              MyTexts.myPoints,
              style: TextStyle(
                  fontSize: 18,
                  color: dark ? MyColors.whiteColor : MyColors.blackColor),
            ),
          ]),
//todo add image string
          WidgetTitle(
            title: MyTexts.tayarhPoints,
            image: '',
            bgColor: MyColors.mainColor.withOpacity(0.4),
            isPoint: true,
            points: '3444',
          ),

          const SizedBox(
            height: 10,
          ),

          /// progress
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              MyTexts.progress,
              style: TextStyle(
                  fontSize: 18,
                  color: dark ? MyColors.whiteColor : MyColors.blackColor),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          ProgressWidget(
            date: DateTime(2024 , 3 , 29 , 12 ,00 ),
            points: '12',
          )
        ],
      ),
    );
  }
}

