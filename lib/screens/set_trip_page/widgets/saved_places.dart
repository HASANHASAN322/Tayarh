import 'package:flutter/material.dart';

import '../../../theme/dark_mode.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/size.dart';

class SavedPlaces extends StatelessWidget {
  const SavedPlaces({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context) ;
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.all(MySize.defaultSpace),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Colors.grey.withOpacity(0.6), width: 1)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: MyColors.mainColor.withOpacity(0.3),
            child: Icon(
              Icons.location_on,
              color: MyColors.mainColor,
              size: 18,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            'Future City',
            style: TextStyle(
                fontSize: 14,
                color: dark
                    ? MyColors.whiteColor
                    : MyColors.blackColor),
          )
        ],
      ),
    );
  }
}
