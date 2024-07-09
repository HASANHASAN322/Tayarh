import 'package:flutter/material.dart';
import '../../constant/size.dart';
import '../../constant/text_strings.dart';
import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';
import '../../widgets/notifications_info/notifications_info.dart';


class NotificationsScreen  extends StatelessWidget {
  const NotificationsScreen ({super.key});


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
        child: SingleChildScrollView(
          child: Column(children: [
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

            /// header
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                MyTexts.notifications,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: dark ? MyColors.whiteColor : MyColors.blackColor),
              ),
            ]),

            const SizedBox(
              height: MySize.spaceBtwItems,
            ),

            /// widget title and state
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>  const NotificationsInfo(
                  firstCity: 'first',
                  targetCity: 'target',
                  cash: '26',
                  isCompleted: true,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: MySize.spaceBtwItems,
                ),
                itemCount: 5)
          ]),
        ));
  }
}
