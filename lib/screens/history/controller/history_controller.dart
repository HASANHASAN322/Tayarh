import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  bool isLoading = false;
  final String userId;
  HistoryController(this.userId);

  QuerySnapshot<Map<String, dynamic>>?  info;

  @override
  void onInit() {
    getDataHistory();
    super.onInit();
  }

  void getDataHistory() {
    isLoading = true;


    FirebaseFirestore.instance
        .collection('history').where('userId', isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        info = snapshot;

        update();
        isLoading = false;
      } else {
        print("No data found in home collection.");
      }
    });
  }
}
