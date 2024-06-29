import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../theme/dark_mode.dart';
import '../../../../utils/constant/colors.dart';
import '../controller/login_controller.dart';

class PhoneNumberFieldWidget extends StatelessWidget {
  const PhoneNumberFieldWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = DarkMode.isDarkMode(context);
    return IntlPhoneField(
      controller: controller.phoneController,
      showDropdownIcon: false,
      countries: controller.countries,
      flagsButtonPadding:
      const EdgeInsets.symmetric(horizontal: 10),
      cursorColor: MyColors.mainColor,
      disableLengthCheck: true,
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20),
        labelText: 'Phone Number',
        labelStyle: TextStyle(color: MyColors.borderColor),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: MyColors.borderColor, width: 1.2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
            BorderSide(color: MyColors.borderColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.red, width: 1.2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.red, width: 1.2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: MyColors.borderColor, width: 1.2)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: MyColors.borderColor, width: 1.2)),
      ),
      initialCountryCode:
      controller.selectedCountryCode.value,
      pickerDialogStyle: PickerDialogStyle(
          backgroundColor: dark
              ? MyColors.darkColor
              : MyColors.whiteColor),
      onChanged: (phone) {
        controller.changeCountry(phone.completeNumber);
      },
      validator: (value) {
        if (value == null ) {
          return 'Phone number is required';
        }
        return null;
      },
    );
  }
}