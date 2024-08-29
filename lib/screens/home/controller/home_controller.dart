import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tayarh/screens/favorite/controller/favorites_controller.dart';
import 'package:tayarh/screens/my_wallet_page/my_wallet_page.dart';
import 'package:tayarh/utils/constant/colors.dart';
import 'package:tayarh/widgets/popup/popup.dart';
import '../../favorite/favorites_screen.dart';
import '../../favorite/select_location_screen.dart';
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
  String myPoints = '';
  bool isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _mapSubscription;
  final favController = Get.put(FavoritesController('5xez1UVKnoyKeAVoinOt')) ;

  @override
  void onInit() {
    super.onInit();
    getDataMap();
    getCurrentLocation();
    getPoints();
  }

  @override
  void onClose() {
    _mapSubscription?.cancel();
    super.onClose();
  }

  ///===================================== Get Data Functions =======================================

  void getPoints() async {
    DocumentSnapshot points = await FirebaseFirestore.instance
        .collection('users')
        .doc("5xez1UVKnoyKeAVoinOt")
        .get();
    myPoints = points['points'].toString();
    update() ;
  }

  Future<void> getDataMap() async {
    isLoading = true;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc("5xez1UVKnoyKeAVoinOt")
        .collection('places')
        .get();

    info = doc;
    update();
    isLoading = false;
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
    update();
  }


  Future<void> showAddGroupDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String placeName = '';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Group Name" , style: TextStyle(fontSize: 18),),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('you can add favorite places to this group on Favorite page .') ,
                const SizedBox(height: 10,) ,
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a group name.";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    placeName = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child:  Text("Cancel" , style: TextStyle(color: MyColors.redColor , fontSize: 16),),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child:  Text("Create" , style: TextStyle(color: MyColors.mainColor, fontSize: 16)),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await addPlace(placeName, []);
                  Get.back();
                  MyPobUp.successSnackBar(title: 'added successfully!');
                  getDataMap() ;
                }
              },
            ),
          ],
        );
      },
    );
  }



  Future<void> addPlace(String name, List<Map<String, dynamic>> placesList) async {

    Map<String, dynamic> data = {
      'name': name,
      'fav': placesList,
    };

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc("5xez1UVKnoyKeAVoinOt")
          .collection('places')
          .add(data);

    } catch (e) {
      MyPobUp.errorSnackBar(title: 'add place field' , message: e);

    }
  }


  void endTheTrip() {
    isWay = false;
    update();
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

  Future<dynamic> openSelectLocationScreen(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) =>  SelectLocationScreen(
        onLocationSelected:
            (LatLng location) {
          favController.showAddPlaceDialog(
              context, location, favController);
        },
      ),
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
