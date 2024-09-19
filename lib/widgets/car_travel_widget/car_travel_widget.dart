import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/screens/home/controller/home_controller.dart';
import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';

  class CarTravelWidget extends StatelessWidget {
    const CarTravelWidget({
      super.key,
    });

    @override
    Widget build(BuildContext context) {
      final homeController = HomeController.instance;
      final dark = DarkMode.isDarkMode(context);

      return Container(
        height: 160,
        padding: const EdgeInsets.all(10),
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
        child: Column(
          children: [
            SizedBox(
              height: 96,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// car number
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.6)),
                          color: dark
                              ? MyColors.darkColor.withOpacity(0.4)
                              : MyColors.whiteColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Obx(() => Text(
                            homeController.carCode.value,
                            style: TextStyle(
                              color: dark
                                  ? MyColors.whiteColor
                                  : MyColors.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )),
                        ),
                      ),

                      /// car type
                      Obx(() => Text(
                        homeController.model.value,
                        style: TextStyle(
                          color: dark
                              ? MyColors.whiteColor
                              : MyColors.blackColor,
                          fontSize: 16,
                        ),
                      )),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  const Image(image: AssetImage('assets/car.png')),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        child: const Image(
                          image: AssetImage('assets/driver.png'),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// name
                          Obx(() => Text(
                            homeController.name.value,
                            style: TextStyle(
                              color: dark
                                  ? MyColors.whiteColor
                                  : MyColors.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )),

                          /// rate and trips number
                          Obx(() => Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellowAccent,
                                size: 15,
                              ),
                              Text(
                                homeController.rate.value,
                                style: TextStyle(
                                  color: dark
                                      ? MyColors.whiteColor
                                      : MyColors.blackColor,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 5,) ,
                              Text(
                                '${homeController.rateCount}+ Trips',
                                style: TextStyle(
                                  color: dark
                                      ? MyColors.whiteColor
                                      : MyColors.blackColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),

                  /// contact btn
                 homeController.canCallDriver.value ? Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: MyColors.mainColor.withOpacity(0.4),
                        ),
                        child: const Center(
                          child: Image(
                            image: AssetImage('assets/message.png'),
                            fit: BoxFit.contain,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: MyColors.mainColor.withOpacity(0.4),
                        ),
                        child: const Center(
                          child: Image(
                            image: AssetImage('assets/call.png'),
                            fit: BoxFit.contain,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ) : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
