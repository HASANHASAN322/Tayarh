


import 'dart:convert';

import 'package:get/get.dart';
import 'package:tayarh/utils/resources/shared_prefrences_keys.dart';
import 'package:tayarh/utils/sevices/services.dart';

import '../constant/constant_data.dart';
import '../models/user_model.dart';

setMyUser(UserModel newUser) {
  ConstData.myUser = newUser;
  MyServices myServices = Get.find();
  myServices.sharedPreferences
      .setString(SharedPreferencesKeys.myUserKey, jsonEncode(newUser.toJson()));
}