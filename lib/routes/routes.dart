import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tayarh/screens/authentication/login/login.dart';
import '../screens/authentication/login/controller/login_binding.dart';


List<GetPage<dynamic>>? routes = [
  GetPage(
    name: "/login",
    page: () => const Login(),
    binding: LoginBinding(),
  )
];
