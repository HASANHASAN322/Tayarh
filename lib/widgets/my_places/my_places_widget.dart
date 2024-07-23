import 'package:flutter/material.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../main_btn/main_btn.dart';

class MyPlacesWidget extends StatelessWidget {

 final bool? isWay;
  const MyPlacesWidget({
    super.key,  this.isWay,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 35,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            MainButton(title: isWay!?'OTP':'New Place', fontSize: 14, onPressed: () {}),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: MySize.sm),
              width: 2,
              height: 26,
              color: MyColors.mainColor,
            ),
            ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MainButton(
                      title: isWay!?"1":'Home',
                      fontSize: 14,
                      isBlue: false,
                      onPressed: () {});
                },
                separatorBuilder: (context, index) => const SizedBox(
                      width: MySize.sm,
                    ),
                itemCount: 6)
          ],
        ),
      ),
    );
  }
}
