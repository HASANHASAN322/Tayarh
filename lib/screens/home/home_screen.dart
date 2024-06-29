import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tayarh/theme/dark_mode.dart';
import 'package:tayarh/widgets/back_btn/back_btn.dart';
import 'package:tayarh/widgets/my-drawer.dart';
import 'package:tayarh/widgets/point_btn/point_btn.dart';
import 'package:tayarh/widgets/wallet_btn/wallet_btn.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
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
    final homeController = Get.put(HomeController());

    return Scaffold(
        key: homeController.scaffoldKey,

        drawer: MyDrawer(),
        body: SafeArea(
            child: Stack(children: [

              /// Map
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Obx(() {
                  return GoogleMap(
                    mapType: MapType.terrain,
                    initialCameraPosition: CameraPosition(
                      target:
                      LatLng(
                          homeController.lat.value, homeController.long.value),
                      zoom: 14.4746,
                    ),
                    onMapCreated: (GoogleMapController mapController) {
                      _controller.complete(mapController);
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  );
                }),
              ),

              /// Drawer and point
              Positioned(
                left: MySize.defaultSpace,
                top: MySize.defaultSpace,
                child: Row(
                  children: [
                    Back(
                      icon: Icons.menu,
                      onPressed: () => homeController.openDrawer(),
                    ),
                    PointButton(
                      onTap: () => homeController.openPointBottomSheet(context),
                      points: 3600,
                    ),
                  ],
                ),
              ),

              /// Wallet
              Positioned(
                top: MySize.defaultSpace,
                right: MySize.defaultSpace,
                child: MyWalletButton(
                  onTap: () {},
                ),
              ),

              /// Get Location by Floating Action Button
              Positioned(
                bottom: 230,
                right: MySize.defaultSpace,
                child: FloatingActionButton(
                  onPressed: () async {
                    final GoogleMapController mapController = await _controller
                        .future;
                    mapController.animateCamera(
                      CameraUpdate.newLatLng(
                        LatLng(homeController.lat.value,
                            homeController.long.value),
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

              /// New Places
              const Positioned(
                  bottom: 190,
                  left: MySize.defaultSpace,
                  right: MySize.defaultSpace,
                  child: MyPlacesWidget()),

              /// where to ?
              const Positioned(
                bottom: MySize.defaultSpace * 2.5,
                left: MySize.defaultSpace,
                right: MySize.defaultSpace,
                child: WhereToWidget(),
              ),
            ])));
  }

}
      key: homeController.scaffoldKey,
        body: SafeArea(
            child: Stack(children: [
      /// Map
      SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(() {
          return GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(homeController.lat.value, homeController.long.value),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController mapController) {
              _controller.complete(mapController);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          );
        }),
      ),

      /// Drawer and point
      Positioned(
        left: MySize.defaultSpace,
        top: MySize.defaultSpace,
        child: Row(
          children: [
            Back(
              icon: Icons.menu,
              onPressed: ()=> homeController.openDrawer(),
            ),
             PointButton(
              onTap: ()=> homeController.openPointBottomSheet(context),
              points: 3600,
            ),
          ],
        ),
      ),

      /// Wallet
      Positioned(
        top: MySize.defaultSpace,
        right: MySize.defaultSpace,
        child: MyWalletButton(
          onTap: () => homeController.openWalletBottomSheet(context),
        ),
      ),

      /// Get Location by Floating Action Button
      Positioned(
        bottom: 230,
        right: MySize.defaultSpace,
        child: FloatingActionButton(
          onPressed: () async {
            final GoogleMapController mapController = await _controller.future;
            mapController.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(homeController.lat.value, homeController.long.value),
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

      /// New Places
      const Positioned(
          bottom: 190,
          left: MySize.defaultSpace,
          right: MySize.defaultSpace,
          child: MyPlacesWidget()),
      const Positioned(
        bottom: MySize.defaultSpace * 2.5,
        left: MySize.defaultSpace,
        right: MySize.defaultSpace,
        child: WhereToWidget(),
      ),
    ])));
  }
}

