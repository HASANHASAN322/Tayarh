import 'package:flutter/material.dart';

import '../../constant/size.dart';
import '../../utils/constant/colors.dart';
import '../main_btn/main_btn.dart';

class MyPlacesWidget extends StatelessWidget {
  final bool? isWay;
  final List? placses;

  const MyPlacesWidget({
    super.key,
    this.isWay,
    this.placses,
  });

  @override
  Widget build(BuildContext context) {
    final placesList = placses ?? [];

    return SizedBox(
      width: double.infinity,
      height: 35,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            MainButton(
              title: isWay! ? 'OTP' : 'New Place',
              fontSize: 14,
              onPressed: () {
                print("Places List Length: ${placesList.length}");
                print("Places List Content: $placesList");
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: MySize.sm),
              width: 2,
              height: 26,
              color: MyColors.mainColor,
            ),
            if (placesList.isEmpty)
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
            else
              ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MainButton(
                    title: isWay! ? "1" : placesList[index].toString(),
                    fontSize: 14,
                    isBlue: false,
                    onPressed: () {
                      print("Selected Place: ${placesList[index]}");
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: MySize.sm,
                ),
                itemCount: placesList.length,
              )

            // ListView.separated(
              //   scrollDirection: Axis.horizontal,
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (context, index) {
              //     return MainButton(
              //       title: isWay! ? "1" : placesList[index].toString(),
              //       fontSize: 14,
              //       isBlue: false,
              //       onPressed: () {
              //         print("Selected Place: ${placesList[index]}");
              //       },
              //     );
              //   },
              //   separatorBuilder: (context, index) => const SizedBox(
              //     width: MySize.sm,
              //   ),
              //   itemCount: placesList.length,
              // ),
          ],
        ),
      ),
    );
  }
}
