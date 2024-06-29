import 'package:flutter/material.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/text_strings.dart';



class MyWalletButton extends StatelessWidget {
  const MyWalletButton({
    super.key, required this.onTap,
  });

  final void Function() onTap ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 45,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: MyColors.mainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet,
              color: MyColors.whiteColor,
              size: 25,
            ),
            const SizedBox(width: 3,) ,
             Text(
              MyTexts.wallet,
              style: TextStyle(fontSize: 14 , color: MyColors.whiteColor),
            )
          ],
        ),
      ),
    );
  }
}
