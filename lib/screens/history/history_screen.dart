import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/screens/history/widgets/title_and_state.dart';
import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../utils/constant/text_strings.dart';
import 'controller/history_controller.dart';

class MyHistory extends StatelessWidget {
  const MyHistory({super.key});

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
                MyTexts.history,
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

          GetBuilder(
              init: HistoryController("5xez1UVKnoyKeAVoinOt"),
              builder: (controller) =>
                  ListView.separated(
             shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemBuilder: (context, index) =>   HistoryInfo(
                // date: controller.info!.docs[index].data()['date'],
                 firstCity: controller.info!.docs[index].data()['firstCity'],
                 targetCity: controller.info!.docs[index].data()['targetCity'],

                 price: controller.info!.docs[index].data()["price"],
                  isCompleted: controller.info!.docs[index].data()['completed']??false,
               ),
               separatorBuilder: (context, index) => const SizedBox(
                 height: MySize.spaceBtwItems,
               ),
               itemCount:  controller.info!.docs.length))
          ]),
        ));
  }
}

