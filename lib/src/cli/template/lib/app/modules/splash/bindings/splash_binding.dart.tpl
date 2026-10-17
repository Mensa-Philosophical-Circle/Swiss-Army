import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // put, not lazyPut: nothing on the splash screen reads the controller, so a lazy one would never start.
    Get.put<SplashController>(SplashController());
  }
}
