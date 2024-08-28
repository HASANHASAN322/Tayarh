import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final String userId;
  FavoritesController(this.userId);

  var favoritePlaces = <String>[].obs; // List of place names
  var placeFavorites = {}.obs; // Map to hold favorites for each place
bool isLoading=false;
  @override
  void onInit() {
    super.onInit();
    print('[GETX] Instance "FavoritesController" has been created');
    fetchPlacesAndFavorites();
  }

  @override
  void onReady() {
    super.onReady();
    print('[GETX] Instance "FavoritesController" has been initialized');
  }

  @override
  void onClose() {
    super.onClose();
    print('[GETX] Instance "FavoritesController" has been closed');
  }

  void fetchPlacesAndFavorites() async {
    try {
      // Reference to the user's 'home' document
      DocumentReference homeRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('home')
          .doc('1HjyA4PpJL6tG3jGkaFh'); // Replace with your actual homeId

      DocumentSnapshot homeDoc = await homeRef.get();

      if (homeDoc.exists) {
        // Clear previous data
        favoritePlaces.clear();
        placeFavorites.clear();

        // Get the places array
        List<dynamic> places = homeDoc['places'];
        for (var place in places) {
          favoritePlaces.add(place.toString());

          // Fetch the corresponding document from the 'favorite' collection
          QuerySnapshot favoritesSnapshot = await FirebaseFirestore.instance
              .collection('favorite')
              .where('homeId', isEqualTo: '1HjyA4PpJL6tG3jGkaFh')
              .where('my_location', isEqualTo: place)
              .get();

          // Collect all favorites for this place
          var favoritesList = favoritesSnapshot.docs.map((doc) => doc.data()).toList();
          placeFavorites[place.toString()] = favoritesList;

          print('Fetched ${favoritesList.length} favorites for place: $place');
        }

        update();
      } else {
        print('No home document found for the specified homeId.');
      }
    } catch (e) {
      print('Error fetching places and favorites: $e');
    }
  }
}
