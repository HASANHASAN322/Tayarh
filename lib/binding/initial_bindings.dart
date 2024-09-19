import 'package:get/get.dart';
import 'package:tayarh/screens/home/controller/home_controller.dart';
import '../screens/set_trip_page/controller/set_trip_controller.dart';
import '../utils/class/crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SetTripController());

  }
}