import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:tayarh/screens/authentication/pin_code/pin_code_screen.dart';
import 'package:tayarh/widgets/popup/popup.dart';

import '../../../home/home_screen.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final RxString selectedLanguage = 'English'.obs;

  final RxString selectedCountryCode = '963'.obs;
  final privacyPolicy = true.obs;
  String? verificationId;
  var showDropdown = false.obs;
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
    const Country(
      name: 'Syria',
      flag: 'sy',
      code: 'SY',
      dialCode: '963',
      nameTranslations: <String, String>{},
      minLength: 1,
      maxLength: 9,
    ),
  ];

  void toggleDropdown() {
    showDropdown.value = !showDropdown.value;
  }

  void changeLanguage(String language) {
    if (language == 'Arabic') {
      selectedLanguage.value = 'Arabic';
      Get.updateLocale(const Locale('ar', 'AR'));
    } else {
      selectedLanguage.value = 'English';
      Get.updateLocale(const Locale('en', 'US'));
    }
  }

  void changeCountry(String value) {
    selectedCountryCode.value = value;
    update();
  }
  void signIn(){
    try {

      if (phoneController.text.isEmpty) {
        MyPobUp.warningSnackBar(
            title: 'Please write an valid PhoneNumber',
            message:
            'PhoneNumber Is Required') ;
        return;
      }
update() ;
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
      Get.to(() =>  PinCodePage(verificationId: '',));

    } catch (e) {
      /// show errors to user
      MyPobUp.errorSnackBar(title: 'Something wrong', message: e.toString());
    }
  }


  ///========================================send sms code================

  void sendSmsVerification() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+${selectedCountryCode.value}${phoneController.text.trim()}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          MyPobUp.successSnackBar(
              title: 'Congratulations',
              message: 'Phone number automatically verified and user signed in.');
          Get.to(() => const HomeScreen());
        },
        verificationFailed: (FirebaseAuthException e) {
          MyPobUp.errorSnackBar(title: 'Verification failed', message: e.message ??
              'An error occurred during verification');
        },
        codeSent: (String verificationId, int? resendToken) {
          MyPobUp.successSnackBar(
              title: 'Verification code sent',
              message: 'A verification code has been sent to your phone.');
          this.verificationId = verificationId;

          Get.to(() => PinCodePage(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
        },
      );
    } catch (e) {
      MyPobUp.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  ///========================================sign with sms code================
  void signInWithSmsCode(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: smsCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      MyPobUp.successSnackBar(
          title: 'Phone Verified',
          message: 'Your phone number has been verified.');
      Get.to(() => const HomeScreen());
    } catch (e) {
      MyPobUp.errorSnackBar(title: 'Invalid Code', message: e.toString());
    }
  }


}
