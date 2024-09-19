import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/screens/home/controller/home_controller.dart';
import 'package:tayarh/screens/set_trip_page/controller/set_trip_controller.dart';
import 'package:tayarh/screens/set_trip_page/widgets/saved_places.dart';
import 'package:tayarh/utils/constant/text_strings.dart';
import 'package:tayarh/widgets/main_btn/main_btn.dart';
import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';

class SetTripWidget extends StatelessWidget {
  const SetTripWidget({
    super.key,
    required this.fromLat,
    required this.fromLong,
  });

  final double fromLat;
  final double fromLong;

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    final homeController = Get.put(HomeController()) ;
    return GetBuilder(
        init: SetTripController(),
        builder: (controller) => Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.all(MySize.defaultSpace),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: dark ? MyColors.darkColor : MyColors.whiteColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 10,
                      decoration: BoxDecoration(
                        color: MyColors.borderColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(
                      height: MySize.spaceBtwSections,
                    ),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: dark
                                  ? MyColors.formColor
                                  : MyColors.borderColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundColor: MyColors.greenColor,
                                        ),
                                      ),
                                      hintText: 'Your Location',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        MyColors.greenColor.withOpacity(0.3),
                                    child: Icon(
                                      Icons.location_on,
                                      color: MyColors.greenColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: dark
                                  ? MyColors.formColor
                                  : MyColors.borderColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller: controller.whereToController,
                                    onChanged: (val) {
                                      if (val.length >= 2) {
                                        controller.getSuggestion(val);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundColor: MyColors.mainColor,
                                        ),
                                      ),
                                      hintText: MyTexts.whereTo,
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        MyColors.mainColor.withOpacity(0.3),
                                    child: Icon(
                                      Icons.location_on,
                                      color: MyColors.mainColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: MySize.spaceBtwItems,
                          ),
                          const SizedBox(
                            height: MySize.spaceBtwItems,
                          ),
                          Container(
                            height: 1,
                            margin: const EdgeInsets.symmetric(
                              vertical: MySize.spaceBtwItems,
                            ),
                            color: Colors.grey,
                          ),
                          Text(
                            'Suggests',
                            style: TextStyle(
                              fontSize: 20,
                              color: dark
                                  ? MyColors.whiteColor
                                  : MyColors.blackColor,
                            ),
                          ),
                          const SizedBox(
                            height: MySize.spaceBtwItems,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final place = controller.addAutoFill[index];
                              return GestureDetector(
                                onTap: () async {
                                  String placeId = place['place_id'];
                                  String placeName = place['description'];
                                  await controller.fetchPlaceDetails(
                                      placeId, placeName);
                                },
                                child: SavedPlaces(
                                  city: place[
                                      'description'], // Pass the description here
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: controller.addAutoFill.length,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   'Recent rides',
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     color: dark ? MyColors.whiteColor : MyColors.blackColor,
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: MySize.spaceBtwItems,
                          // ),
                          // ListView.separated(
                          //   shrinkWrap: true,
                          //   physics: const NeverScrollableScrollPhysics(),
                          //   itemBuilder: (context, index) => const SavedPlaces(
                          //     city: 'Sample Ride',
                          //   ),
                          //   separatorBuilder: (context, index) => const SizedBox(
                          //     height: 10,
                          //   ),
                          //   itemCount: 1,
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          controller.whereToController.text.isEmpty
                              ? const SizedBox()
                              :  MainButton(
                                  height: 40,
                                  width: double.infinity,
                                  title: controller.isLoading ? 'Wait' : 'Select a driver'.tr,
                                  onPressed: () => controller.startTheTrip(
                                      fromLat: fromLat,
                                      fromLong: fromLong,
                                      whereToLat: controller.whereTOLat,
                                      whereToLong: controller.whereTOLong),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
