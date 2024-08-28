import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MyWalletController extends GetxController {
  bool isLoading = false;
  final String userId;
  MyWalletController(this.userId);

  QuerySnapshot<Map<String, dynamic>>?  info;

  @override
  void onInit() {
    getDataMyWallet();
    super.onInit();
  }

  void getDataMyWallet() {
    isLoading = true;


    FirebaseFirestore.instance
        .collection('my_wallet').where('userId', isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        info = snapshot;
        print("Data fetched: ${snapshot.docs.first.data()}");

        update();
        isLoading = false;
      } else {
        print("No data found in home collection.");
      }
    });
  }
}
