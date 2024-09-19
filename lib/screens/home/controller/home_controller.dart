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
  var lat = 31.7225;
  var long = 35.9933;
  QuerySnapshot<Map<String, dynamic>>? info;
  String myPoints = '';
  bool isLoading = false;
  RxBool canCallDriver = false.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _mapSubscription;
  final favController = Get.put(FavoritesController('5xez1UVKnoyKeAVoinOt')) ;

  List<Marker> markers = [];
  late final Marker fromTrip;
  late final Marker whereToTrip;
  final RxDouble tripDist = 0.0.obs;
  var polylines = <Polyline>{}.obs;
  RxBool isWay =false.obs;
  RxBool driverSelected =false.obs;
  RxBool canOrder =false.obs;
  var name= ''.obs;
  var rate= ''.obs;
  var rateCount= ''.obs;
  var model= ''.obs;
  var carCode= ''.obs;
  var driverId= ''.obs;

  @override
  void onInit() {
    super.onInit();
    getDataMap();
    getCurrentLocation();
    getPoints();
    getDriversMap();
    // getTripsMap();
  }
  @override
  void onClose() {
    _mapSubscription?.cancel();
    super.onClose();
  }

  ///===================================== Get Data Functions =======================================

  /// get points
  void getPoints() {
    FirebaseFirestore.instance
        .collection('users')
        .doc("5xez1UVKnoyKeAVoinOt")
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        myPoints = snapshot['points'].toString();
        update();
      } else {
        // Handle the case where the document doesn't exist or has no data
        myPoints = "0";
        update();
      }
    });
  }
  /// get places
  void getDataMap() {
    isLoading = true;
    FirebaseFirestore.instance
        .collection('users')
        .doc("5xez1UVKnoyKeAVoinOt")
        .collection('places')
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      info = snapshot; // Update the info variable with the new snapshot
      update(); // Notify listeners to update the UI
      isLoading = false;
    });
  }
  /// get drivers
  void getDriversMap() async {
    isLoading = true;
    FirebaseFirestore.instance
        .collection('driver')
        .snapshots()
        .listen((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        markers.clear();
        for (var doc in snapshot.docs) {

          if (doc['status'] == 'available') {
            GeoPoint geoPoint = doc['current_location'];
            final String carCode = doc['code'];
            final String name = doc['name'];
            final String rate = doc['rate'];
            final String rateCount = doc['rate_count'].toString();
            final String model = doc['model'];
            final String driverId = doc.id;

            final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(48, 48)),
              'assets/icons/taxi.png',
            );

            Marker marker = Marker(
              onTap: () {
                this.carCode.value = carCode;
                this.name.value = name;
                this.rate.value = rate;
                this.rateCount.value = rateCount;
                this.model.value = model;
                this.driverId.value = driverId;

                canOrder.value = true;
              },
              markerId: MarkerId(doc.id),
              position: LatLng(geoPoint.latitude, geoPoint.longitude), // Correctly using lat/lng here
              icon: customIcon,
              infoWindow: InfoWindow(title: "Driver: $name"),
            );
            markers.add(marker);
          }
        }

        isLoading = false;
        update();
      } else {
        throw ("No drivers found in the driver collection.");
      }

      isLoading = false;
    });
  }



  /// drawer
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
    update();
  }
  /// add group
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
  /// add place
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

/// ======================================= trip function ================================================

  void endTheTrip(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("End Trip Request"),
          content: const Text("The request will be sent to the driver to end the trip from you both. We hope that the trip was good for you."),
          actions: [
            TextButton(
              onPressed: () {
                isLoading = true ;
                isWay.value = false ;
                canCallDriver.value = false ;
                driverSelected.value = false ;
                canOrder.value = false ;
                Navigator.of(context).pop();
                isLoading = false ;
                update();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }


  /// ==========================================================================================================


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
      builder: (_) =>  SetTripWidget(fromLat: lat,fromLong: long,),
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

    // Continuously check and request for location services to be enabled
    while (true) {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        MyPobUp.warningSnackBar(title: 'We Need Location Service Enabled');
        // Optionally, add a delay before checking again to avoid spamming the user
        await Future.delayed(const Duration(seconds: 5));
        continue; // Continue the loop if the service is not enabled
      }
      break; // Exit the loop if the service is enabled
    }

    // Check and request for location permissions
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

    // Get the current location if all conditions are met
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    long = position.longitude;
  }

}
