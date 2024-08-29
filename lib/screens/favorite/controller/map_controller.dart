import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapController extends GetxController {
  late GoogleMapController mapController;
  Rx<LatLng> selectedLocation = const LatLng(37.42796133580664, -122.085749655962).obs;

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    selectedLocation.value = LatLng(position.latitude, position.longitude);
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: selectedLocation.value, zoom: 14),
      ),
    );
  }

  void updateLocation(LatLng newPosition) {
    selectedLocation.value = newPosition;
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
