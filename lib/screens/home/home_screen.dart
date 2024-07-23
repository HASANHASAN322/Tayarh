import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tayarh/theme/dark_mode.dart';
import 'package:tayarh/widgets/back_btn/back_btn.dart';
import 'package:tayarh/widgets/main_btn/main_btn.dart';
import 'package:tayarh/widgets/my_drawer.dart';
import 'package:tayarh/widgets/point_btn/point_btn.dart';
import 'package:tayarh/widgets/wallet_btn/wallet_btn.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../widgets/car_travel_widget/car_travel_widget.dart';
import '../../widgets/my_places/my_places_widget.dart';
import '../../widgets/where_to/where_to_widget.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final dark = DarkMode.isDarkMode(context);

    return GetBuilder(
      init: HomeController(),
      builder: (homeController) => Scaffold(
          key: homeController.scaffoldKey,
          drawer: const MyDrawer(),
          body: SafeArea(
              child: Stack(children: [
            /// Map
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(homeController.lat, homeController.long),
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController mapController) {
                    _controller.complete(mapController);
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                )),

            /// Drawer and point
            homeController.isWay
                ? Positioned(
                    left: MySize.defaultSpace,
                    top: MySize.defaultSpace,
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        color: dark
                            ? MyColors.darkColor.withOpacity(0.8)
                            : MyColors.whiteColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => homeController.endTheTrip(),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
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
                          onTap: () =>
                              homeController.openPointBottomSheet(context),
                          points: 3600,
                        ),
                      ],
                    ),
                  ),

            /// Wallet
            homeController.isWay
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
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
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

            /// Get Location by Floating Action Button
            Positioned(
              bottom: homeController.isWay ? 275 : 230,
              right: MySize.defaultSpace,
              child: FloatingActionButton(
                onPressed: () async {
                  final GoogleMapController mapController =
                      await _controller.future;
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
            ),
            homeController.isWay
                ? Positioned(
                    bottom: 230,
                    right: MySize.defaultSpace,
                    left: MySize.defaultSpace,
                    child: MainButton(
                        height: 40, title: 'Save This Place', onPressed: () {}))
                : Container(),

            /// New Places
            homeController.isWay
                ? Positioned(
                    bottom: 190,
                    left: MySize.defaultSpace,
                    right: MySize.defaultSpace,
                    child: MyPlacesWidget(
                      isWay: homeController.isWay,
                    ))
                : Positioned(
                    bottom: 190,
                    left: MySize.defaultSpace,
                    right: MySize.defaultSpace,
                    child: MyPlacesWidget(isWay: homeController.isWay)),

            /// where to ?
            homeController.isWay
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
                      onTap: () => homeController.openTripBottomSheet(context),
                    ),
                  ),
          ]))),
    );
  }
}
