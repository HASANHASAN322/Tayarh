import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tayarh/utils/constant/colors.dart';

import '../../utils/constant/text_strings.dart';
import 'controller/map_controller.dart';

class SelectLocationScreen extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  final Function(LatLng) onLocationSelected;

  SelectLocationScreen({required this.onLocationSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 70),
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            color: MyColors.whiteColor,
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios)),
                 Text(
                  MyTexts.selectLocation,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    onLocationSelected(mapController.selectedLocation.value);
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: MyColors.mainColor,
                        borderRadius: BorderRadius.circular(10)),
                    child:  Center(child: Text(MyTexts.save)),
                  ),
                )
              ],
            ),
          )),
      body: Obx(
        () => Stack(
          children: [
            GoogleMap(
              onMapCreated: mapController.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: mapController.selectedLocation.value,
                zoom: 14.0,
              ),
              onTap: (LatLng tappedLocation) {
                // Update marker position on tap
                mapController.updateLocation(tappedLocation);
              },
              markers: {
                Marker(
                  markerId: const MarkerId('selectedLocation'),
                  position: mapController.selectedLocation.value,
                  draggable: true,
                  onDragEnd: (newPosition) {
                    mapController.updateLocation(newPosition);
                  },
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
