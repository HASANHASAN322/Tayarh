import 'package:get/get.dart';
import 'package:tayarh/utils/sevices/services.dart';
import '../resources/shared_prefrences_keys.dart';
class AppLink {
  static String appRoot = "FirebaseFirestore.instance";
  // static Future<QuerySnapshot<Map<String, dynamic>>> firebaseApihome = FirebaseFirestore.instance
  //     .collection('map').get();
}

MyServices myServices = Get.find();
Map<String, String> getHeader() {
  Map<String, String> mainHeader = {
    'Content-Type': 'multipart/form-data',
  };
  return mainHeader;
}

Map<String, String> getHeaderToken() {
  Map<String, String> mainHeader = {
    'Content-Type': 'multipart/form-data',
    // 'Accept': 'application/json',
    // 'X-Requested-With': 'XMLHttpRequest',
    'Authorization':
          'Bearer ${myServices.sharedPreferences.getString(SharedPreferencesKeys.tokenKey)}',
  };
  return mainHeader;
}
