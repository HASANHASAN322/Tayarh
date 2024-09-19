import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/screens/home/controller/home_controller.dart';

import '../../constant/size.dart';
import '../../utils/constant/colors.dart';
import '../main_btn/main_btn.dart';

class MyPlacesWidget extends StatelessWidget {
  final bool? isWay;

  const MyPlacesWidget({
    super.key,
    this.isWay,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 35,
      child: GetBuilder(
          init: HomeController(),
          builder: (homeController) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            MainButton(
              title: 'New Group',
              fontSize: 14,
              onPressed: ()=> homeController.showAddGroupDialog(context) ,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: MySize.sm),
              width: 2,
              height: 26,
              color: MyColors.mainColor,
            ),
            homeController.info == null || homeController.info!.docs.isEmpty ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MySize.sm),
                child: Text(
                  'No Places Available',
                  style: TextStyle(
                    fontSize: 14,
                    color: MyColors.mainColor,
                  ),
                ),
              )
            :
              ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MainButton(
                    title:homeController.info!.docs[index]['name'].toString(),
                    fontSize: 14,
                    isBlue: false,
                    onPressed: () {

                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: MySize.sm,
                ),
                itemCount: homeController.info!.docs.isEmpty ? 0 :homeController.info!.docs.length ,
              )

          ],
        ),
      )),
    );
  }
}
