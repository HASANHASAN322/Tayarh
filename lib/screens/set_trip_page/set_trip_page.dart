import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/screens/set_trip_page/controller/set_trip_controller.dart';
import 'package:tayarh/screens/set_trip_page/widgets/saved_places.dart';
import 'package:tayarh/utils/constant/text_strings.dart';
import 'package:tayarh/widgets/main_btn/main_btn.dart';
import 'package:tayarh/widgets/my_places/my_places_widget.dart';
import '../../theme/dark_mode.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';

class SetTripWidget extends StatelessWidget {
  const SetTripWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);
    return GetBuilder<SetTripController>(
      init: SetTripController(),
      builder: (controller) =>  Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(MySize.defaultSpace),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: dark ? MyColors.darkColor : MyColors.whiteColor),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                width: 80,
                height: 10,
                decoration: BoxDecoration(
                    color: MyColors.borderColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                height: MySize.spaceBtwSections,
              ),

              /// Form
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// from
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: dark ? MyColors.formColor : MyColors.borderColor,
                        borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
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
                                hintText: 'PickUp Point',
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 14)),
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
                            ))
                      ],
                    ),
                  ),

                  /// to
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: dark ? MyColors.formColor : MyColors.borderColor,
                        borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            controller: controller.whereToController,
                            onChanged: (val){
                              if (val.length >= 2) {
                                controller.getSuggestion(
                                  val,
                                );
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
                                    color: Colors.grey, fontSize: 14)),
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
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: MySize.spaceBtwItems,
                  ),

                  /// add places
                  const MyPlacesWidget(isWay: false,
                  ),
                  const SizedBox(
                    height: MySize.spaceBtwItems,
                  ),

                  /// divider
                  Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(
                        vertical: MySize.spaceBtwItems),
                    color: Colors.grey,
                  ),

                  Text(
                    'Suggests',
                    style: TextStyle(
                        fontSize: 20,
                        color: dark ? MyColors.whiteColor : MyColors.blackColor),
                  ),
                  const SizedBox(
                    height: MySize.spaceBtwItems,
                  ),

                  /// saved places
                  ListView.separated(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>  SavedPlaces(
                        cities: controller.addAutoFill,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: controller.addAutoFill.length) ,
                  /// Recent rides
                  const SizedBox(
                    height: 10,
                  ) ,
                  Text(
                    'Recent rides',
                    style: TextStyle(
                        fontSize: 20,
                        color: dark ? MyColors.whiteColor : MyColors.blackColor),
                  ),
                  const SizedBox(
                    height: MySize.spaceBtwItems,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => const SavedPlaces(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: 1) ,
                  const SizedBox(height: 10,) ,
                  MainButton(
                      height: 40,
                      width: double.infinity,
                      title: 'Order a car', onPressed: ()=> controller.startTheTrip())
                ],
              ))
            ]),
          )),
    );
  }
}
