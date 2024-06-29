import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tayarh/screens/authentication/login/controller/login_controller.dart';
import 'package:tayarh/screens/authentication/login/widgets/phone_number_field.dart';
import 'package:tayarh/screens/authentication/login/widgets/term_of_use.dart';
import 'package:tayarh/theme/dark_mode.dart';
import 'package:tayarh/utils/constant/text_strings.dart';
import 'package:tayarh/widgets/main_btn/main_btn.dart';

import '../../../utils/constant/colors.dart';
import '../../../widgets/appbar/appbar.dart';
import '../../../widgets/welcome/welcome.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = DarkMode.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? MyColors.darkColor : MyColors.whiteColor,
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            /// welcome
            const Expanded(
              flex: 2,
              child: Welcome(),
            ),

            /// Form
            Expanded(
              flex: 4,
              child: Form(
                  key: controller.signInFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      const PhoneNumberFieldWidget(),

                      /// term and login
                      Column(
                        children: [
                          /// terms of service
                          const TermOfUseWidget(),
                          const SizedBox(
                            height: 10,
                          ),

                          /// login btn
                          MainButton(
                            title: MyTexts.signIn,
                            onPressed: () => controller.signIn(),
                            width: double.infinity,
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}


