import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:tayarh/widgets/popup/popup.dart';
import '../../../home/home_screen.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final RxString selectedLanguage = 'English'.obs;
  final RxString selectedCountryCode = '20'.obs;
  final privacyPolicy = true.obs;
  final phoneController = TextEditingController() ;
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();


  final List<Country>? countries = [
    const Country(
      name: 'Egypt',
      flag: '🇪🇬',
      code: 'EG',
      dialCode: '20',
      nameTranslations: <String, String>{},
      minLength: 1,
      maxLength: 10,
    ),
    const Country(
      name: 'Saudi Arabia',
      flag: '🇸🇦',
      code: 'SA',
      dialCode: '966',
      nameTranslations: <String, String>{},
      minLength: 1,
      maxLength: 9,
    ),
  ];

  void changeLanguage(String language) {
    selectedLanguage.value = language;
  }

  void changeCountry(String value) {
    selectedCountryCode.value = value;
    update();
  }



  void signIn(){
    try {

      if (!signInFormKey.currentState!.validate()) {
        MyPobUp.warningSnackBar(
            title: 'Please write an valid PhoneNumber',
            message:
            'PhoneNumber Is Required') ;
        return;
      }

      /// privacy policy check
      if (!privacyPolicy.value) {
        MyPobUp.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
            'In order to Login,  you must have to read and accept the Privacy Policy & Term of Services');
        return;
      }

      /// show success message

      MyPobUp.successSnackBar(
          title: 'Congratulations',
          message: 'You need to verify your number now!');

      /// move to verify email screen
      Get.to(() => HomeScreen());

    } catch (e) {
      /// show errors to user
      MyPobUp.errorSnackBar(title: 'Something wrong', message: e.toString());
    }
  }
}
