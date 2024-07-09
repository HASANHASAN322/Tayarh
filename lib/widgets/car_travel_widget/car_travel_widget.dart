import 'package:flutter/material.dart';
import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';

class CarTravelWidget extends StatelessWidget {
  const CarTravelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: dark
            ? MyColors.darkColor.withOpacity(0.8)
            : MyColors.whiteColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
        children: [
            Container(
            width: 100,
              height: 40,
              decoration: BoxDecoration(
      color: dark
          ? MyColors.darkColor.withOpacity(0.8)
          : MyColors.whiteColor.withOpacity(0.8),
     // borderRadius: BorderRadius.circular(5.0),
              ),
            child: Center(child: Text("BB 92 FC",style: TextStyle(color: MyColors.blackColor,fontWeight: FontWeight.bold),)),

            ),
          Text("Toyota-Corolla - Black"),
          SizedBox(height: 15,),
          Text("3min - 0.8km"),

        ],
      ),
    );
  }
}