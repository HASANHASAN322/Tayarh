import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/utils/constant/image_strings.dart';
import 'package:tayarh/utils/constant/text_strings.dart';

import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../widgets/progress_widget/progress_widget.dart';
import '../../widgets/widget_title/widget_title.dart';
import 'controller/my_point_controller.dart';

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
      child: GetBuilder<MyPointsController>(
          init: MyPointsController("5xez1UVKnoyKeAVoinOt"),
          builder: (controller) {
            if (controller.myPoints == '') {
              return const Center(child: CircularProgressIndicator());
            }

            var myPointField = controller.myPoints;

            if (myPointField == '') {
              return const Center(
                  child: Text("'my_point' field is missing in the document"));
            }
            return Column(
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
                        color:
                            dark ? MyColors.whiteColor : MyColors.blackColor),
                  ),
                ]),
                WidgetTitle(
                  title: MyTexts.tayarhPoints,
                  image: MyImage.pointLogo,
                  bgColor: MyColors.mainColor.withOpacity(0.4),
                  isPoint: true,
                  points: myPointField,
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
                        color:
                            dark ? MyColors.whiteColor : MyColors.blackColor),
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
             SizedBox(
               height: MediaQuery.of(context).size.height * 0.4,
               child:   ListView.separated(
                   shrinkWrap: true,

                   itemBuilder: (context, index) => ProgressWidget(
                     date: controller.info!.docs[index]["date"],
                     points: controller.info!.docs[index]["bonus"],
                   ) ,
                   separatorBuilder: (context, index) => const SizedBox(height: 10,),
                   itemCount: controller.info!.docs.length),
             )
              ],
            );
          }),
    );
  }
}
