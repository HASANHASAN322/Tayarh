
import 'package:get/get.dart';
import 'package:tayarh/screens/authentication/login/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(
      LoginController(),
    );
  }
}