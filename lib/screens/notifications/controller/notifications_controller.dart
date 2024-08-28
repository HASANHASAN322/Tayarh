import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  bool isLoading = false;
  final String userId;
  NotificationsController(this.userId);

  QuerySnapshot<Map<String, dynamic>>?  info;

  @override
  void onInit() {
    getDataNotifications();
    super.onInit();
  }

  void getDataNotifications() {
    isLoading = true;

    isLoading = true;
    FirebaseFirestore.instance
        .collection('notifications').where('userId', isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        info = snapshot;

        update();
      } else {
        print("No data found in home collection.");
      }
    });
  }
}
