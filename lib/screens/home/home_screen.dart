import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tayarh/screens/set_trip_page/controller/set_trip_controller.dart';
import 'package:tayarh/utils/constant/text_strings.dart';
import 'controller/home_controller.dart';
import '../../widgets/back_btn/back_btn.dart';
import '../../widgets/main_btn/main_btn.dart';
import '../../widgets/my_drawer.dart';
import '../../widgets/point_btn/point_btn.dart';
import '../../widgets/wallet_btn/wallet_btn.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../widgets/car_travel_widget/car_travel_widget.dart';
import '../../widgets/where_to/where_to_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    var controller = Get.put(SetTripController());

    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (homeController) => Scaffold(
        key: homeController.scaffoldKey,
        drawer: const MyDrawer(),
        body: homeController.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: MyColors.mainColor,
                ),
              )
            : SafeArea(
                child: Stack(children: [
                /// Map
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Obx(() => GoogleMap(
                        onTap: (argument) {
                          homeController.canOrder.value = false;
                        },
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target:
                              LatLng(homeController.lat, homeController.long),
                          zoom: 14.4746,
                        ),
                        onMapCreated: (GoogleMapController mapController) {
                          homeController.controller.complete(mapController);
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        markers: Set<Marker>.of(homeController.markers),
                        polylines: Set<Polyline>.of(homeController.polylines),
                      )),
                ),

                /// Drawer and point
                Obx(
                  () => homeController.isWay.value
                      ? Container()
                      : Positioned(
                          left: MySize.defaultSpace,
                          top: MySize.defaultSpace,
                          child: Row(
                            children: [
                              Back(
                                icon: Icons.menu,
                                onPressed: () => homeController.openDrawer(),
                              ),
                              PointButton(
                                onTap: () => homeController
                                    .openPointBottomSheet(context),
                                points: homeController.myPoints.toString() == ''
                                    ? '0'
                                    : homeController.myPoints.toString(),
                              ),
                            ],
                          ),
                        ),
                ),

                /// Wallet
                Obx(
                  () => homeController.isWay.value
                      ? Positioned(
                          top: MySize.defaultSpace,
                          right: MySize.defaultSpace,
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: dark
                                      ? MyColors.darkColor.withOpacity(0.8)
                                      : MyColors.whiteColor.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const SizedBox(
                                  width: 110,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.green,
                                        size: 10,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("On The Way"),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: (){},
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: dark
                                        ? MyColors.darkColor.withOpacity(0.8)
                                        : MyColors.whiteColor.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Icon(
                                    Icons.info,
                                    color: Colors.red.withOpacity(0.9),
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Positioned(
                          top: MySize.defaultSpace,
                          right: MySize.defaultSpace,
                          child: MyWalletButton(
                            onTap: () =>
                                homeController.openWalletBottomSheet(context),
                          ),
                        ),
                ),

                /// Get Location by Floating Action Button
                  Obx(()=>homeController.driverSelected.value ?Container():  Positioned(
                    bottom: homeController.isWay.value ? 275 : 230,
                    right: MySize.defaultSpace,
                    child: FloatingActionButton(
                      onPressed: () async {
                        final GoogleMapController mapController =
                        await homeController.controller.future;
                        mapController.animateCamera(
                          CameraUpdate.newLatLng(
                            LatLng(homeController.lat, homeController.long),
                          ),
                        );
                      },
                      backgroundColor: dark
                          ? MyColors.darkColor.withOpacity(0.8)
                          : MyColors.whiteColor.withOpacity(0.8),
                      child: Icon(
                        Icons.my_location,
                        color: MyColors.mainColor,
                      ),
                    ),
                  )),

               Obx(
                  () =>  homeController.isWay.value?
                  Container():
                  homeController.canOrder.value & homeController.driverSelected.value
                      ? Positioned(
                          bottom: 235,
                          right: MySize.defaultSpace,
                          left: MySize.defaultSpace,
                          child: MainButton(
                            height: 40,
                            title: homeController.driverSelected.value
                                ? 'Order this car'
                                : 'Select a driver',
                            isBlue: true,
                            width: double.infinity,
                            onPressed: homeController.driverSelected.value
                                ? () => controller.sendTripRequestToDriver(context)
                                : () {},
                          ),
                        )
                      : Container(),
                ),

                /// New Places
                Obx(

                  () =>  homeController.isWay.value? Positioned(
                      bottom: 190,
                      left: MySize.defaultSpace,
                      right: MySize.defaultSpace,
                      child: MainButton(title: 'End The Trip', onPressed: ()=> homeController.endTheTrip(context))):
                  homeController.driverSelected.value
                      ? Positioned(
                          bottom: 190,
                          left: MySize.defaultSpace,
                          right: MySize.defaultSpace,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MainButton(
                                title:
                                    '${MyTexts.tripCost} : ${(homeController.tripDist * 2).toInt()}',
                                onPressed: () {},
                                width:
                                    MediaQuery.of(context).size.width * 0.4,
                                isBlue: true,
                              ),
                              MainButton(
                                title:
                                    '${MyTexts.tripTime} : ${controller.selectedTime.value.hour.toString()}:${controller.selectedTime.value.minute.toString()}',
                                onPressed: () => controller.pickTime(context),
                                width:
                                    MediaQuery.of(context).size.width  * 0.5,
                                isBlue: false,
                              ),
                            ],
                          ),
                        )
                      : Positioned(
                          bottom: 190,
                          left: MySize.defaultSpace,
                          right: MySize.defaultSpace,
                          child: SizedBox(
                            width: double.infinity,
                            height: 35,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  MainButton(
                                    title: 'New Group',
                                    fontSize: 14,
                                    onPressed: () => homeController
                                        .showAddGroupDialog(context),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: MySize.sm),
                                    width: 2,
                                    height: 26,
                                    color: MyColors.mainColor,
                                  ),
                                  ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return MainButton(
                                        title: homeController
                                            .info!.docs[index]['name']
                                            .toString(),
                                        fontSize: 14,
                                        isBlue: false,
                                        onPressed: () {},
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      width: MySize.sm,
                                    ),
                                    itemCount: homeController.info!.docs.isEmpty
                                        ? 0
                                        : homeController.info!.docs.length,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),

                /// where to ?
                Obx(
                  () => homeController.driverSelected.value
                      ? const Positioned(
                          bottom: MySize.defaultSpace * 2.5,
                          left: MySize.defaultSpace,
                          right: MySize.defaultSpace,
                          child: CarTravelWidget(),
                        )
                      : Positioned(
                          bottom: MySize.defaultSpace * 2.5,
                          left: MySize.defaultSpace,
                          right: MySize.defaultSpace,
                          child: WhereToWidget(
                            onTap: () =>
                                homeController.openTripBottomSheet(context),
                          ),
                        ),
                ),
              ])),
      ),
    );
  }
}


/// back btn
/// Positioned(
//                           left: MySize.defaultSpace,
//                           top: MySize.defaultSpace,
//                           child: Container(
//                             width: 50,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: dark
//                                   ? MyColors.darkColor.withOpacity(0.8)
//                                   : MyColors.whiteColor.withOpacity(0.8),
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Center(
//                               child: IconButton(
//                                 icon: const Icon(Icons.arrow_back),
//                                 onPressed: () => homeController.endTheTrip(),
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                         )
