import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../theme/dark_mode.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/size.dart';

class HistoryInfo extends StatelessWidget {
   HistoryInfo({
    super.key,
   //  required this.date,

    required this.firstCity,
     required this.targetCity,
     required this.isCompleted,
     required this.price
  });

// final Timestamp date;
  final String firstCity;
  final String targetCity;

  final String price;
   final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    // DateTime dateTime = date.toDate();
    // String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: MyColors.borderColor),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// date
                // Text(
                //   formattedDate??"",
                //   style: TextStyle(
                //       fontSize: 14,
                //       color: dark ? MyColors.whiteColor : MyColors.blackColor),
                // ),

                /// progress state
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color:isCompleted ? MyColors.greenColor.withOpacity(0.3) : MyColors.redColor.withOpacity(0.3) ),
                  child: Center(
                      child: Text(
                       isCompleted ? 'Completed' : 'Canceled',
                        style: TextStyle(color:isCompleted ?  MyColors.greenColor :  MyColors.redColor),
                      )),
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MySize.defaultSpace),
            child: Column(
              children: [
                /// first City
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: MyColors.greenColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      firstCity,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: dark ? MyColors.whiteColor : MyColors.blackColor),
                    )
                  ],
                ),
                const SizedBox(
                  height: MySize.spaceBtwItems / 2,
                ),

                /// Target City
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: MyColors.mainColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      targetCity,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: dark ? MyColors.whiteColor : MyColors.blackColor),
                    )
                  ],
                ) ,
                const SizedBox(
                  height: MySize.spaceBtwItems ,
                ),
                /// cash
                Row(
                  children: [
                    Text(
                      '\$',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color:
                          MyColors.greenColor),
                    ),
                    const SizedBox(width: 5,) ,
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color:
                          dark ? MyColors.whiteColor : MyColors.blackColor),
                    ),
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
