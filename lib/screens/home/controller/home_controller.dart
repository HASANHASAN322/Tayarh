import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tayarh/screens/my_wallet_page/my_wallet_page.dart';
import 'package:tayarh/widgets/popup/popup.dart';

import '../../history/history.dart';
import '../../my_points_page/my_points_page.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  var lat = 34.7918927.obs;
  var long = 36.3609726.obs;
   bool is_way=true;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

void openDrawer(){
    scaffoldKey.currentState?.openDrawer() ;
    update() ;

}

  Future<dynamic> openPointBottomSheet(BuildContext context){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => const MyPoints(),) ;
}

Future<dynamic> openWalletBottomSheet(BuildContext context){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => const MyWallet(),) ;
}

Future<dynamic> openHistoryBottomSheet(BuildContext context){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => const MyHistory(),) ;
}

Future<dynamic> openSettingBottomSheet(BuildContext context){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => const MySettings(),) ;
}

Future<dynamic> openTripBottomSheet(BuildContext context){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => const SetTripWidget(),) ;
}


  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      MyPobUp.warningSnackBar(title: 'We Need Location Service Enabled');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        MyPobUp.errorSnackBar(title: 'Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      MyPobUp.errorSnackBar(
          title: 'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    // When we reach here, permissions are granted and we can continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat.value = position.latitude;
    long.value = position.longitude;


  }
}
