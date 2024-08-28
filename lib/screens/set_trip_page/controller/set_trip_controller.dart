

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tayarh/constant/constant_data.dart';
import 'package:uuid/uuid.dart';
class SetTripController extends GetxController{


  List addAutoFill = [];
  bool isWay = false;
  TextEditingController whereToController = TextEditingController() ;

  void startTheTrip(){
    isWay = true ;
    Get.back() ;
    update() ;
  }


  Future<void> getSuggestion(String input) async {
    // Generate a new session token for each request
    String sessionToken = Uuid().v4();

    String type = '(regions)';
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&type=$type&key=${ConstData.mapKey}&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      print(response.body);
      addAutoFill = json.decode(response.body)['predictions'];
      print('===================================================');
      print(addAutoFill);
      print('====================================================');
      update() ;
      // valueNotifierHome.incrementNotifier();
    } else {
      // valueNotifierHome.incrementNotifier();
      throw Exception('Failed to load predictions');
    }
    update() ;
  }


  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    getSuggestion('') ;
  }
}