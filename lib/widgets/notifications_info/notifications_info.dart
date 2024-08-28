import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../theme/dark_mode.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/size.dart';

class NotificationsInfo extends StatelessWidget {
   NotificationsInfo({
    super.key,
    // required this.firstCity,
    // required this.targetCity,
    // required this.cash,
    // required this.isCompleted,
    required this.notifications
  });

  Map<String, dynamic> notifications ;

  // final String firstCity;
  // final String targetCity;
  // final String cash;
  // final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);

    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: MyColors.borderColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/icons/notifications_icon.png"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${notifications["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: dark ? MyColors.whiteColor : MyColors.blackColor,
                      ),
                    ),
                    const SizedBox(height: MySize.spaceBtwItems / 2),
                    Text(
                    "${notifications["description"]}",  textAlign: TextAlign.start,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 14,
                        color: dark ? MyColors.whiteColor : MyColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
