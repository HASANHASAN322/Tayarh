import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tayarh/screens/my_wallet_page/my_wallet_page.dart';
import 'package:tayarh/widgets/popup/popup.dart';
import '../../favorite/favorites_screen.dart';
import '../../history/history_screen.dart';
import '../../my_points_page/my_points_page.dart';
import '../../notifications/notifications_screen.dart';
import '../../set_trip_page/set_trip_page.dart';
import '../../setting/setting.dart';



class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final Completer<GoogleMapController> controller =
  Completer<GoogleMapController>();
  var lat = 34.7918927;
  var long = 36.3609726;
  bool isWay = false;
  QuerySnapshot<Map<String, dynamic>>? info;
  String myPoints = '' ;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _mapSubscription;

  @override
  void onInit() {
    super.onInit();
    getDataMap();
    getCurrentLocation();
    getPoints() ;
  }
  @override
  void onClose() {
    _mapSubscription?.cancel();
    super.onClose();
  }


  ///===================================== Get Data Functions =======================================


  void getPoints() async{
    DocumentSnapshot points = await FirebaseFirestore.instance
        .collection('users')
        .doc("5xez1UVKnoyKeAVoinOt").get() ;
    myPoints = points['points'].toString() ;
  }


  Future<void> getDataMap() async {
    isLoading = true ;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc("5xez1UVKnoyKeAVoinOt").collection('places').get() ;

    info = doc;
    update() ;
isLoading = false ;

    }




  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
    update();
  }
  void endTheTrip(){
    isWay = false ;
    update() ;
  }
  ///=================================== Open pages ===========================================
  Future<dynamic> openNotificationBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const NotificationsScreen(),
    );
  }

  Future<dynamic> openFavoriteBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const FavoriteScreen(),
    );
  }

  Future<dynamic> openPointBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const MyPoints(),
    );
  }

  Future<dynamic> openWalletBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const MyWallet(),
    );
  }

  Future<dynamic> openHistoryBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const MyHistory(),
    );
  }

  Future<dynamic> openSettingBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const MySettings(),
    );
  }

  Future<dynamic> openTripBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const SetTripWidget(),
    );
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
          title:
              'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    // When we reach here, permissions are granted and we can continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
  }
}
