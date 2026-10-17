import 'package:get/get.dart';

import '../../home/bindings/home_binding.dart';
import '../../profile/bindings/profile_binding.dart';
import '../controllers/main_controller.dart';

/// The shell holds its tabs, so it sets up what each tab needs.
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    HomeBinding().dependencies();
    ProfileBinding().dependencies();
  }
}
