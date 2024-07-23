import 'package:get/get.dart';
import 'package:tayarh/utils/sevices/services.dart';

import '../resources/shared_prefrences_keys.dart';

class AppLink {
  static String appRoot = "https://tayarh.com/hakimtest/public/";

  // static String imageWithRootUrl = ('$appRoot/storage');

  static String imagesAirline = ('$appRoot/storage');
  static String imagesCategories = ('$appRoot/storage');

  static String imagesProfile = ('$appRoot/storage');

  static String imagesTraveler = ('$appRoot/storage');

  // static String imageWithRootUrlPublic = ('$appRoot/public');

  static String imageWithoutRootUrl = (appRoot);
  static String serverApiRoot = "$appRoot/api/v1";

///======================================================

  static String getMyPlaces = "$serverApiRoot/";
  static String getSuggestPlaces = "$serverApiRoot/";
  static String register = "$serverApiRoot/auth/register";
  static String login = "$serverApiRoot/login";
  static String logout = "$serverApiRoot/logout";

  static String home = "$serverApiRoot/home";

  static String myreservations = "$serverApiRoot/users/reservations";
  static String user = "$serverApiRoot/user";
  static String cities = "$serverApiRoot/cities?paginate=0";
  static String travels = "$serverApiRoot/travels";
  static String reservationsPost = "$serverApiRoot/reservations";
  static String profile = "$serverApiRoot/user";
  static String notification = "$serverApiRoot/notification";

//getSections
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
