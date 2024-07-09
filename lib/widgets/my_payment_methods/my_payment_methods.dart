import 'package:flutter/material.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../utils/constant/text_strings.dart';

class MyPaymentMethods extends StatelessWidget {
  const MyPaymentMethods({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
              color: MyColors.greenColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              MyTexts.cash,
              style: TextStyle(
                  fontSize: 16,
                  color: MyColors.greenColor),
            ),
          ),
        ) ,
        Container(
          margin: const EdgeInsets.symmetric(horizontal: MySize.sm),
          width: 2,
          height: 30,
          color: MyColors.borderColor,
        ),
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
              color: MyColors.mainColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              '+ ${MyTexts.addPaymentMethods}',
              style: TextStyle(
                  fontSize: 16,
                  color: MyColors.mainColor),
            ),
          ),
        ) ,
      ],);
  }
}
