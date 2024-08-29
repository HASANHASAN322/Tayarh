import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MyPointsController extends GetxController {
  bool isLoading = false;
  final String userId;
  MyPointsController(this.userId);

  String myPoints = '' ;
  QuerySnapshot<Map<String, dynamic>>?  info;

  @override
  void onInit() {
    getDataMyPoints();
    getDataMap() ;
    super.onInit();
  }


  Future<void> getDataMap() async {
    isLoading = true;
    try{
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc("5xez1UVKnoyKeAVoinOt").collection('added_points').get() ;

      info = doc;

    } catch(e){
      throw '$e' ;
    }
    isLoading = false;
  }


  void getDataMyPoints() async {
    isLoading = true;

    DocumentSnapshot points = await FirebaseFirestore.instance
        .collection('users')
        .doc("5xez1UVKnoyKeAVoinOt").get() ;
    myPoints = points['points'].toString() ;
        update();
    isLoading = false;

  }
}
