import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:auto_sms_verification/auto_sms_verification.dart';
import 'package:tayarh/screens/home/home_screen.dart';
import '../../../theme/dark_mode.dart';
import '../../../utils/constant/colors.dart';
import '../login/controller/login_controller.dart';

class PinCodePage extends StatefulWidget {
  final String? verificationId;

  const PinCodePage({super.key, required this.verificationId});

  @override
  _PinCodePageState createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  final TextEditingController pinController = TextEditingController();

  @override
  void initState() {
    super.initState();

    AutoSmsVerification.startListeningSms().then((sms) {
      if (sms != null) {
        // Automatically extract the code from the received SMS
        String code = extractCodeFromSms(sms);
        pinController.text = code;
        verifyCode();
      } else {
        Get.snackbar('Error', 'Failed to receive the verification code automatically.');
      }
    });
  }

  @override
  void dispose() {
    AutoSmsVerification.stopListening();
    pinController.dispose();
    super.dispose();
  }

  String extractCodeFromSms(String sms) {
    final regExp = RegExp(r'\d{6}');
    final match = regExp.firstMatch(sms);
    return match?.group(0) ?? '';
  }

  void verifyCode() {
    if (widget.verificationId != null && pinController.text.isNotEmpty) {
      final controller = Get.find<LoginController>();
      controller.signInWithSmsCode(pinController.text);
      Get.to(HomeScreen());
    } else {
      Get.snackbar('Error', 'Please enter the PIN code.');
    }
  }

  @override
  Widget build(BuildContext context) {

    final dark = DarkMode.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Verification Code'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'We have sent a verification code to your phone number. Please enter it below.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 6,
              controller: pinController,
              keyboardType: TextInputType.number,
              // decoration: InputDecoration(
              //   border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   hintText: 'Enter PIN Code',
              // ),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.grey.shade200,
                selectedFillColor: Colors.white,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
                selectedColor: Colors.blue,
              ),
              onChanged: (value) {},
              onCompleted: (value) {
                verifyCode();
              },
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap:(){},
              child: Container(
                  height: 60,
                  width: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: dark
                          ? MyColors.hintColor.withOpacity(0.6)
                          : MyColors.hintColor.withOpacity(0.2)),
                  child: Center(
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        fontSize: 15,
                        color: dark ? MyColors.whiteColor : MyColors.darkColor,
                      ),
                    ),
                  )),
            ),

          ],
        ),
      ),
    );
  }
}
