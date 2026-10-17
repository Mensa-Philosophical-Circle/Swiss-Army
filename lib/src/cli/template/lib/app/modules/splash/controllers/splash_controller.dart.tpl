import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  static const _showFor = Duration(seconds: 2);

  @override
  void onInit() {
    super.onInit();
    // Check a saved session here and go to Routes.MAIN instead when there is one.
    Future.delayed(_showFor, () => Get.offAllNamed(Routes.SIGN_IN));
  }
}
