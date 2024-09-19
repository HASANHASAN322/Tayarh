import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tayarh/screens/home/home_screen.dart';
import 'package:tayarh/widgets/popup/popup.dart';

class FavoritesController extends GetxController {
  final String userId;
  FavoritesController(this.userId);

  QuerySnapshot<Map<String, dynamic>>? favoritePlaces; // List of place names
  List<QueryDocumentSnapshot<Map<String, dynamic>>> placeFavorites = []; // Map to hold favorites for each place
bool isLoading=false;
  @override
  void onInit() {
    super.onInit();
    fetchPlacesAndFavorites();
  }



  void showAddPlaceDialog(
      BuildContext context, LatLng location, FavoritesController controller) {
    String name = '';
    String description = '';
    String? selectedTab;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Place info"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dropdown menu to select a tab
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Select a Group"),
                items: controller.favoritePlaces!.docs.map((doc) {
                  return DropdownMenuItem<String>(
                    value: doc['name'],
                    child: Text(doc['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedTab = value;
                },
                validator: (value) =>
                value == null ? 'Please select a tab' : null,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(labelText: "Place Name"),
                onChanged: (value) {
                  name = value;
                },
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(labelText: "Description"),
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () async {
                if (selectedTab == null) {
                  Get.snackbar(
                    'Error',
                    'Please select a tab before adding the place.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }
                if (name.isNotEmpty) {
                  try {
                    // Find the document where the 'name' field matches 'selectedTab'
                    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                        .collection('users')
                        .doc("5xez1UVKnoyKeAVoinOt")
                        .collection('places')
                        .where('name', isEqualTo: selectedTab)
                        .limit(1)
                        .get();
                    if (querySnapshot.docs.isNotEmpty) {
                      String docId = querySnapshot.docs.first.id;

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc("5xez1UVKnoyKeAVoinOt")
                          .collection('places')
                          .doc(docId)
                          .update({
                        'fav': FieldValue.arrayUnion([
                          {
                            'name': name,
                            'description': description,
                            'latitude': location.latitude,
                            'longitude': location.longitude,
                            'date': DateTime.now(),
                          }
                        ]),
                      });
                      Get.back();
                      MyPobUp.successSnackBar(title: 'Added successfully');
                      Get.offAll(const HomeScreen());
                    } else {
                      Get.snackbar(
                        'Error',
                        'No document found with the selected tab name.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      'Failed to add place: $e',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                } else {
                  Get.snackbar(
                    'Error',
                    'Please enter a place name.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }



  void fetchPlacesAndFavorites() async {
    isLoading=true;
    try {
      final placesRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('places')
          .get();

      favoritePlaces = placesRef ;
      placeFavorites = placesRef.docs ;
      update() ;
      isLoading=false;
    } catch (e) {
      throw 'Error fetching places and favorites: $e';
    }
  }
}
