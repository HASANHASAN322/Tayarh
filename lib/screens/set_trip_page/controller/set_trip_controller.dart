

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:tayarh/constant/constant_data.dart';
import 'package:tayarh/screens/home/controller/home_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../models/trip_model.dart';
import '../../../widgets/popup/popup.dart';
class SetTripController extends GetxController{


  List addAutoFill = [];
 final homeController = Get.put(HomeController());
  TextEditingController whereToController = TextEditingController() ;

   late double whereTOLat ;
   late double whereTOLong ;
  late Marker fromMarker;
  late Marker whereToMarker;
   late
   GeoPoint startTravel ;
   late GeoPoint endTravel ;
   bool isLoading = false ;

  final  Rx<TimeOfDay> selectedTime  = TimeOfDay.now().obs;

  Future<void> pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );

    if (pickedTime != null && pickedTime != selectedTime.value) {
      selectedTime.value = pickedTime;  // Update selectedTime
    }
  }


  void startTheTrip({
    required double fromLat,
    required double fromLong,
    required double whereToLat,
    required double whereToLong,
  }) async {
    isLoading = true ;
    print('=========================== started ====================') ;
    // Set the start and end GeoPoints
    startTravel = GeoPoint(fromLat, fromLong);
     endTravel = GeoPoint(whereToLat, whereToLong);

    // Create markers for the start and end locations
    Marker fromMarker = Marker(
      markerId: const MarkerId('fromMarker'),
      position: LatLng(fromLat, fromLong),
      infoWindow: const InfoWindow(title: 'Start Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    print('=========================== marker1  ====================') ;

    Marker whereToMarker = Marker(
      markerId: const MarkerId('whereToMarker'),
      position: LatLng(whereToLat, whereToLong),
      infoWindow: const InfoWindow(title: 'Destination'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    print('=========================== marker 2 ====================') ;


    // Add the markers to the homeController
    homeController.markers.add(fromMarker);
    homeController.markers.add(whereToMarker);

    print('=========================== all added ====================') ;

    // Calculate the distance between the two markers
    double distanceInMeters = Geolocator.distanceBetween(
      fromLat,
      fromLong,
      whereToLat,
      whereToLong,
    );
    homeController.tripDist.value = distanceInMeters / 1000 ;

    // Instantiate PolylinePoints
    PolylinePoints polylinePoints = PolylinePoints();

    // Get the polyline points from Google Maps Directions API
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: 'AIzaSyDEU0SDALQ9C0PBycbw9j9eNPbTlaaN2Ic',
      request: PolylineRequest(
        origin: PointLatLng(fromLat, fromLong),
        destination: PointLatLng(whereToLat, whereToLong),
        mode: TravelMode.driving,
      ),
    );

    // Check if the result is successful
    if (result.points.isNotEmpty) {
      // Convert the points to LatLng
      List<LatLng> polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      // Create a Polyline
      Polyline tripPolyline = Polyline(
        polylineId: const PolylineId('tripPolyline'),
        color: Colors.blue,
        width: 5,
        points: polylineCoordinates,
      );



      homeController.polylines.add(tripPolyline);
      homeController.driverSelected.value = true ;

    } else {
      // Handle error if no points found
      print('No points found for the route');
    }

   isLoading = false ;

    print('=========================== done ====================') ;

    // Update the UI
    update();
    Get.back();
    update();
  }



  Future<void> getSuggestion(String input) async {
    String sessionToken = const Uuid().v4();

    String type = '(regions)';
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&type=$type&key=${ConstData.mapKey}&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      addAutoFill = json.decode(response.body)['predictions'];
      update() ;

    } else {
      // valueNotifierHome.incrementNotifier();
      throw Exception('Failed to load predictions');
    }
    update() ;
  }

  Future<void> fetchPlaceDetails(String placeId, String placeName) async {
    String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request = '$baseURL?place_id=$placeId&key=${ConstData.mapKey}';

    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      var placeDetails = json.decode(response.body)['result'];
      double lat = placeDetails['geometry']['location']['lat'];
      double lng = placeDetails['geometry']['location']['lng'];

      // Now update the text field controller and handle lat/lng as needed
      whereToController.text = placeName;

      whereTOLat = lat;
      whereTOLong = lng;

      update();
    } else {
      throw Exception('Failed to load place details');
    }
  }
  ///========================================================================================
  void sendTripRequestToDriver(BuildContext context) async {

    try {
      final now = DateTime.now();
      final selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.value.hour,   // Hour from TimeOfDay
        selectedTime.value.minute, // Minute from TimeOfDay
      );

      await FirebaseFirestore.instance
          .collection('driver')
          .doc(homeController.driverId.value)
          .collection('trip_requests')
          .add(
          TripModel(
            status: 'waiting',
            driverId: homeController.driverId.value,
            userId: '5xez1UVKnoyKeAVoinOt',
            cost: (homeController.tripDist * 2).toInt().toString(),
            startPoint: startTravel,
            endPoint: endTravel,
            timestamp: selectedDateTime,  // Correct DateTime object
          ).toJson());

      listenForTripAcceptance(context, homeController.driverId.value);
      update() ;
      print('===============sent to ${homeController.driverId.value}');

    } catch (error) {
      print('Failed to send trip request: $error');
      throw "Failed to send trip request: $error";
    }
  }



  void listenForTripAcceptance(BuildContext context, String selectedDriverId) {
    FirebaseFirestore.instance
        .collection('driver') // Ensure this is the correct path
        .doc(selectedDriverId)
        .collection('trip_requests')
        .snapshots()
        .listen((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = snapshot.docs.first;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String status = data['status'];

        // Handle waiting status
        if (status == 'waiting') {
          showDialog(
            context: context,
            barrierDismissible: false, // Prevent dismissing the dialog
            builder: (BuildContext context) {
              return homeController.isWay.value
                  ? Container()
                  : const Dialog(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text("Waiting for driver response..."),
                    ],
                  ),
                ),
              );
            },
          );
        }

        // Handle accepted status
        if (status == 'accepted') {
          homeController.isWay.value = true;
          homeController.canCallDriver.value = true;

          try {
            // Delete the document after acceptance
            await FirebaseFirestore.instance
                .collection('driver') // Ensure correct path
                .doc(selectedDriverId)
                .collection('trip_requests')
                .doc(doc.id)
                .delete();

            // Close the dialog properly
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            MyPobUp.successSnackBar(
                title: 'Trip Accepted',
                message: 'You can message the driver for more info');

            update();
          } catch (e) {
            // Handle errors in deletion
            MyPobUp.warningSnackBar(
                title: 'Error',
                message: 'Could not delete the document or close the dialog.');
          }
        }

        // Handle rejected status
        if (status == 'rejected') {
          // Close the dialog properly
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }

          MyPobUp.warningSnackBar(
              title: 'Trip Rejected',
              message: 'The Driver is busy now, you can order another one.');

          try {
            // Optionally, delete the request here as well
            await FirebaseFirestore.instance
                .collection('driver') // Ensure correct path
                .doc(selectedDriverId)
                .collection('trip_requests')
                .doc(doc.id)
                .delete();
          } catch (e) {
            MyPobUp.warningSnackBar(
                title: 'Error',
                message: 'Could not delete the rejected trip request.');
          }
        }
      }
    });
  }





  @override
  void onInit() {
    super.onInit();

    // TODO: implement onInit
    getSuggestion('') ;
  }
}