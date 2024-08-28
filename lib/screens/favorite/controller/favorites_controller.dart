import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
