import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    super.key,
    required this.date,
    required this.points,
  });

  final DateTime date;
  final String points;

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.all(MySize.defaultSpace),
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// date
              Text(
                DateFormat('yyyy-MM-dd').format(date).toString(),
                style: TextStyle(
                    fontSize: 12,
                    color: dark ? MyColors.whiteColor : MyColors.blackColor),
              ),

              /// progress state
              Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyColors.greenColor.withOpacity(0.3)),
                child: Center(
                    child: Text(
                  'Added',
                  style: TextStyle(color: MyColors.greenColor),
                )),
              )
            ],
          ),

          /// points added
          Text(
            '+$points',
            style: TextStyle(
                fontSize: 15,
                color: dark ? MyColors.whiteColor : MyColors.blackColor),
          ),
        ],
      ),
    );
  }
}
